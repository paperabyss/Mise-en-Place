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

        container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
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
                recipe.recipeDescription = "This sure is a recipe"
                tag.addToRecipes(recipe)

                for k in 1...5 {
                    let ingredient = Ingredient(context: viewContext)
                    let unitNames = ["grams", "ounces", "mililitters"]
                    ingredient.massUnit = "grams"
                    ingredient.massValue = Double(Int.random(in: 1...100))
                    ingredient.name = "Ingredient \(k) for recipe \(j)"
                    recipe.addToIngredients(ingredient)
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
}
