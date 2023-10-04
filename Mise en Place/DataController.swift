//
//  DataController.swift
//  Mise en Place
//
//  Created by Tanner King on 8/28/23.
//

import CoreData

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer

    @Published var selectedFilter: Filter? = Filter.all
    @Published var selectedRecipe: Recipe? 

    @Published var filterText = "" 

    private var saveTask: Task<Void, Error>?

    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        dataController.createSampleData()
        return dataController
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

        container.persistentStoreDescriptions.first?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        NotificationCenter.default.addObserver(forName: .NSPersistentStoreRemoteChange, object: container.persistentStoreCoordinator, queue: .main, using: remoteStoreChanged)

        container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }


    func remoteStoreChanged(_ notification: Notification) {
        objectWillChange.send()
    }

    func createSampleData() {
        let viewContext = container.viewContext

        for i in 1...5{
            let tag = Tag(context: viewContext)
            tag.id = UUID()
            tag.name = "Tag \(i)"

            for j in 1...5 {
                let recipe = Recipe(context: viewContext)
                recipe.title = "Recipe \(i)-\(j)"
                recipe.servings = Double(Int.random(in: 1...3))
                recipe.creationDate = .now
                recipe.difficulty = Int16(Int.random(in: 0...2))
                recipe.recipeInformation = "This sure is a recipe"
                recipe.lastMade = .now
                recipe.cookingTime = Int16(Int.random(in: 0...7200))
                tag.addToRecipes(recipe)

                for ingredientNumber in 1...5 {
                    let ingredient = Ingredient(context: viewContext)
                    let unitNames = ["grams", "ounces", "mililitters"]
                    ingredient.massUnit = unitNames[Int.random(in: 0...2)]
                    ingredient.massValue = Double(Int.random(in: 1...100))
                    ingredient.name = "Ingredient \(ingredientNumber) for recipe \(j)"
                    recipe.addToIngredients(ingredient)
                }

                for stepNumber in 1...5 {
                    let step = Step(context: viewContext)
                    step.number = Int16(stepNumber)
                    step.instruction = "Example Instructions"
                    recipe.addToSteps(step)
                }
            }
        }

        try? viewContext.save()
    }

    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }

    func queueSave() {
        saveTask?.cancel()

        saveTask = Task { @MainActor in
            try await Task.sleep(for: .seconds(3))
            save()
        }
    }

    func delete(_ object: NSManagedObject) {
        objectWillChange.send()
        container.viewContext.delete(object)
        save()
    }

    private func delete(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs

        if let delete = try? container.viewContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
            let changes = [NSDeletedObjectsKey: delete.result as? [NSManagedObjectID] ?? []]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [container.viewContext])
        }
    }

    func deleteAll() {
        let request1: NSFetchRequest<NSFetchRequestResult> = Tag.fetchRequest()
        delete(request1)

        let request2: NSFetchRequest<NSFetchRequestResult> = Recipe.fetchRequest()
        delete(request2)

        save()
    }

    func recipesForSelectedFilter() -> [Recipe] {
        let filter = selectedFilter ?? .all
        var predicates = [NSPredicate]()

        if let tag = filter.tag {
            let tagPredicate = NSPredicate(format: "tags CONTAINS %@", tag)
            predicates.append(tagPredicate)
        }
        else {
            let datePredicate = NSPredicate(format: "lastMade > %@", filter.minLastMade as NSDate)
            predicates.append(datePredicate)
        }

        let trimmedFilterText = filterText.trimmingCharacters(in: .whitespaces)

        if !trimmedFilterText.isEmpty {
            let titlePredicate = NSPredicate(format: "title CONTAINS[c] %@", trimmedFilterText)
            let informationPredicate = NSPredicate(format: "information CONTAINS[c] %@", trimmedFilterText)
            let combinedPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [titlePredicate, informationPredicate])
            predicates.append(combinedPredicate)
        }

        let request = Recipe.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)

        let allRecipes = (try? container.viewContext.fetch(request)) ?? []
        return allRecipes.sorted()
    }
}
