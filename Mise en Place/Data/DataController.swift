//
//  DataController.swift
//  Mise en Place
//
//  Created by Tanner King on 8/28/23.
//

import CoreData
import CoreImage
import SwiftUI

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    let userDefault = UserDefaults.standard

    @Published var selectedFilter: Filter? = Filter.all
    @Published var selectedRecipe: Recipe?
    @Published var selectedMeal: Meal?

    @Published var filterText = ""

    @Published var selectedTab = "recipe"
    @Published var selectedTag = ""
    var selectedTags: [Tag] = []

    @Published var filterTags: [Tag] = []
    @Published var filterIngredients: [String] = []
    

    @Published var mealTypes = ["Breakfast", "Lunch", "Dinner"]
    @Published var difficulties = ["Easy", "Medium", "Hard"]
    @Published var plannedMeals = [""]
    @Published var missingMeals = [""]


    @Published var theme: String = (UserDefaults.standard.string(forKey: "Theme") ?? "Default") {
        didSet {
            print(theme)
            userDefault.set(theme, forKey: "Theme")
            Theme.loadTheme()
            save()
            }
        }

    @Published var themes = [
        "Default", // Done
        "Blue", // Done
        "Lilac", // Done
        "Cherry Blossom", // Done
        "Forest", //Done
        "Burnt Orange", //Done
        "Code Green", // Done
        "Sunset", // Done
        "Purple and Pink", // Done
        "Mint", //Done
        "Nana", //Done
        "Momo", //Done
    ]

    @Published var columnSize = 100
    @Published var showRecipeDifficulty: Bool = UserDefaults.standard.bool(forKey: "ShowDifficulty") {
        didSet {
            userDefault.set(showRecipeDifficulty, forKey: "ShowDifficulty" )
        }
    }


    private var saveTask: Task<Void, Error>?

    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        dataController.createSampleData()
        return dataController
    }()

    static let model: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "Main", withExtension: "momd") else {
            fatalError("Failed to locate model file")
        }

        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load model file")
        }

        return managedObjectModel
    }()


    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main", managedObjectModel: Self.model)

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

    var cookingUnits: [String] {
        [
            "",
            "gram",
            "teaspoon",
            "tablespoon",
            "mililitter",
            "litter",
            "ounce",
            "cup",
            "pint",
            "quart",
            "gallon",
        ]
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
                let difficulties = ["Easy", "Medium", "Hard"]
                let recipe = Recipe(context: viewContext)
                recipe.title = "Recipe \(i)-\(j)"
                recipe.id = UUID()
                recipe.servings = Double(Int.random(in: 1...3))
                recipe.creationDate = .now
                recipe.difficulty = difficulties[Int.random(in: 0...2)]
                recipe.recipeInformation = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sollicitudin ac orci phasellus egestas tellus rutrum. Congue nisi vitae suscipit tellus. Neque viverra justo nec ultrices dui sapien eget mi. Congue quisque egestas diam in arcu cursus euismod quis. Amet mattis vulputate enim nulla aliquet porttitor lacus luctus accumsan. Adipiscing enim eu turpis egestas pretium aenean pharetra magna ac. Ut aliquam purus sit amet luctus venenatis lectus magna. Viverra adipiscing at in tellus integer feugiat scelerisque varius. Arcu vitae elementum curabitur vitae nunc sed."
                recipe.lastMade = .now
                recipe.recipeInstructions = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Arcu non sodales neque sodales ut etiam sit. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui. Amet commodo nulla facilisi nullam. Sapien nec sagittis aliquam malesuada bibendum arcu vitae elementum. Purus faucibus ornare suspendisse sed. Magna eget est lorem ipsum dolor sit amet consectetur. Sit amet purus gravida quis blandit turpis cursus in hac. Suspendisse faucibus interdum posuere lorem ipsum dolor sit amet consectetur. Ultrices mi tempus imperdiet nulla malesuada. Dui id ornare arcu odio ut sem. Sed arcu non odio euismod. Pulvinar mattis nunc sed blandit libero. Risus viverra adipiscing at in tellus integer feugiat scelerisque. Tempor nec feugiat nisl pretium fusce id velit ut. Tellus id interdum velit laoreet id donec. Duis ultricies lacus sed turpis tincidunt id aliquet risus. Fermentum posuere urna nec tincidunt praesent semper feugiat nibh. Vel pharetra vel turpis nunc eget lorem dolor sed viverra.\nSit amet consectetur adipiscing elit duis. Malesuada nunc vel risus commodo viverra maecenas accumsan lacus vel. Ultricies tristique nulla aliquet enim tortor at. Eu lobortis elementum nibh tellus molestie. Commodo odio aenean sed adipiscing diam donec. Amet luctus venenatis lectus magna fringilla urna. Tincidunt praesent semper feugiat nibh sed. Elementum nibh tellus molestie nunc. Nisl nunc mi ipsum faucibus vitae. Orci porta non pulvinar neque laoreet suspendisse interdum consectetur. Purus in mollis nunc sed id semper. Vestibulum morbi blandit cursus risus at ultrices mi. Viverra aliquet eget sit amet tellus cras adipiscing.\nFeugiat scelerisque varius morbi enim nunc faucibus a pellentesque. Tristique risus nec feugiat in. Iaculis urna id volutpat lacus laoreet. Nullam ac tortor vitae purus. Tellus cras adipiscing enim eu. Amet porttitor eget dolor morbi non arcu risus quis. At varius vel pharetra vel turpis nunc eget lorem. Sit amet nulla facilisi morbi. Sed vulputate odio ut enim blandit volutpat maecenas. Viverra nibh cras pulvinar mattis nunc sed blandit libero. Potenti nullam ac tortor vitae. Ipsum a arcu cursus vitae congue mauris rhoncus aenean vel. Et netus et malesuada fames ac turpis. Elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique. Venenatis a condimentum vitae sapien pellentesque habitant. Vel risus commodo viverra maecenas. Tristique risus nec feugiat in fermentum posuere urna nec tincidunt. Orci nulla pellentesque dignissim enim sit. Quam adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus."
                recipe.cookingHours = Int16(Int.random(in: 0...23))
                recipe.cookingMinutes = Int16(Int.random(in: 0...60))
                recipe.cookingTime = Int16(Int.random(in: 0...7200))
                tag.addToRecipes(recipe)


                for _ in 1...5 {
                    let cookingIngredients = [
                        "Tofu",
                        "Quinoa",
                        "Lentils",
                        "Chickpeas",
                        "Black beans",
                        "Kidney beans",
                        "Tempeh",
                        "Seitan",
                        "Nutritional yeast",
                        "Coconut milk",
                        "Almond milk",
                        "Soy milk",
                        "Oat milk",
                        "Cashews",
                        "Almonds",
                        "Walnuts",
                        "Peanuts",
                        "Sunflower seeds",
                        "Chia seeds",
                        "Flax seeds",
                        "Hemp seeds",
                        "Sesame seeds",
                        "Pumpkin seeds",
                        "Nut butters (e.g., almond butter, peanut butter)",
                        "Agave syrup",
                        "Maple syrup",
                        "Coconut oil",
                        "Olive oil",
                        "Avocado oil",
                        "Soy sauce",
                        "Tamari",
                        "Coconut aminos",
                        "Balsamic vinegar",
                        "Apple cider vinegar",
                        "Rice vinegar",
                        "Dijon mustard",
                        "Whole grain mustard",
                        "Cumin",
                        "Turmeric",
                        "Paprika",
                        "Cinnamon",
                        "Ginger",
                        "Garlic",
                        "Onion",
                        "Bell peppers",
                        "Spinach",
                        "Kale",
                        "Broccoli",
                        "Zucchini",
                        "Mushrooms",
                        "Tomatoes"
                    ] // Example Ingredients to pull from.
                    let ingredient = Ingredient(context: viewContext)
                    ingredient.id = UUID()
                    ingredient.massUnit = cookingUnits[Int.random(in: 0...8)]
                    ingredient.massValue = Double(Int.random(in: 1...100))
                    ingredient.name = cookingIngredients[Int.random(in: 0...49)] //A random one of the 50 ingredients.
                    recipe.addToIngredients(ingredient)
                }
            }
        }

        try? viewContext.save()
    }

    func newTag() {
        let tag = Tag(context: container.viewContext)
        tag.id = UUID()
        tag.name = NSLocalizedString("New Tag", comment: "Create a new tag")

        save()
    }

    func createNewTagandAddtoRecipe(recipe: Recipe, name: String){
        let tag = Tag(context: container.viewContext)
        tag.name = name
        tag.id = UUID()

        recipe.addToTags(tag)
        save()

    }

    func allTags() -> [Tag] {
        let request = Tag.fetchRequest()
        let allTags = (try? container.viewContext.fetch(request)) ?? []
        return allTags
    }

    func missingTags(from recipe: Recipe) -> [Tag] {
        let request = Tag.fetchRequest()
        let allTags = (try? container.viewContext.fetch(request)) ?? []

        let allTagsSet = Set(allTags)
        let difference = allTagsSet.symmetricDifference(recipe.recipeTags)

        return difference.sorted()
    }

    func newRecipe() {
        let recipe = Recipe(context: container.viewContext)
        recipe.title = "New Recipe"
        recipe.id = UUID()
        recipe.creationDate = .now
        recipe.servings = 1
        recipe.difficulty = "Easy"
        recipe.cookingTime = 0
        recipe.cookingHours = 0
        recipe.cookingMinutes = 0

        if let tag = selectedFilter?.tag {
            recipe.addToTags(tag)
        }

        save()

        selectedRecipe = recipe
    }


    func newStep(recipe: Recipe) {
        let step = Step(context: container.viewContext)

        step.number = Int64((recipe.recipeSteps.last?.number ?? 0) + 1)
        step.id = UUID()
        step.stepInstruction = ""

        recipe.addToSteps(step)
        save()

    }

    func newIngredient(recipe: Recipe) {
        let ingredient = Ingredient(context: container.viewContext)

        ingredient.name = ""
        ingredient.id = UUID()
        ingredient.massValue = 0.0
        ingredient.massUnit = "gram"

        recipe.addToIngredients(ingredient)
        save()
    }

    func newMeal(day: String) {
        let meal = Meal(context: container.viewContext)

        meal.id = UUID()
        meal.name = ""
        meal.type = "Breakfast"
        meal.time = .now
        meal.day = day

        save()

        selectedMeal = meal
    }

    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }

    
    func queueSave() {
        saveTask?.cancel()

        saveTask = Task { @MainActor in
            try await Task.sleep(for: .seconds(0.3))
            save()
        }
    }

    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60)
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

        let request3: NSFetchRequest<NSFetchRequestResult> = Meal.fetchRequest()
        delete(request3)

        

        save()
    }


    func allIngredients() -> [Ingredient]{
        let ingredientsRequest = Ingredient.fetchRequest()
        let allIngredients = (try? container.viewContext.fetch(ingredientsRequest)) ?? []
        return allIngredients.sorted()
    }

    func uniqueIngredients() -> [Ingredient] {
        var uniqueIngredients: [Ingredient] = []
        for ingredient in allIngredients() {
            var match = false
            for uniqueIngredient in uniqueIngredients {
                if uniqueIngredient.ingredientName == ingredient.ingredientName{
                    match = true
                }
            }
            if !match {
                uniqueIngredients.append(ingredient)
            }
        }

        return uniqueIngredients
    }



    func recipesForSelectedFilter() -> [Recipe] {
        var predicates = [NSPredicate]()

        let trimmedFilterText = filterText.trimmingCharacters(in: .whitespaces)

        if !trimmedFilterText.isEmpty {
            let titlePredicate = NSPredicate(format: "title CONTAINS[c] %@", trimmedFilterText)
            let informationPredicate = NSPredicate(format: "information CONTAINS[c] %@", trimmedFilterText)
            let difficultyPredicate = NSPredicate(format: "difficulty CONTAINS[c] %@", trimmedFilterText)
            let ingredientPredicate = NSPredicate(format: "ANY ingredients.name CONTAINS[c] %@", trimmedFilterText) //Any keyword is used for the one to many relationship.
            let combinedPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [titlePredicate, informationPredicate, difficultyPredicate, ingredientPredicate])
            predicates.append(combinedPredicate)
        }

        let request = Recipe.fetchRequest()

        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        

        let allRecipes = (try? container.viewContext.fetch(request)) ?? []

        var recipesForTheCurrentTags: [Recipe] {
            var matches: [Recipe] = allRecipes

            if !filterTags.isEmpty {
                for recipe in allRecipes.sorted() {
                    for filterTag in filterTags {
                        if !recipe.recipeTags.contains(filterTag){
                            matches.removeAll { $0 == recipe}
                        }
                    }
                }
            }
            return matches.sorted()
        }

        var recipesForTheCurrentIngredients: [Recipe] {
            var matches: [Recipe] = recipesForTheCurrentTags
            for recipe in recipesForTheCurrentTags {
                for ingredient in filterIngredients {
                    if !recipe.recipeIngredeintNames.contains(ingredient){
                        matches.removeAll { $0 == recipe}
                    }
                }
            }
            return matches.sorted()
        }
        return recipesForTheCurrentIngredients.sorted()
    }

    func getCurrentWeekDates(date: Date) -> [Date] {
        let calendar = Calendar.current
        let currentDate = date

        // Find the start of the current week (Monday)
        let startOfWeekComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)
        let startDate = calendar.date(from: startOfWeekComponents)!

        // Find the end of the current week (Sunday)
        let endOfWeekComponents = DateComponents(day: 6)
        let endDate = calendar.date(byAdding: endOfWeekComponents, to: startDate)!

        // Generate an array of dates for the current week
        var weekDates: [Date] = []
        var currentDatePointer = startDate

        while currentDatePointer <= endDate {
            weekDates.append(currentDatePointer)
            currentDatePointer = calendar.date(byAdding: .day, value: 1, to: currentDatePointer)!
        }

        return weekDates
    }

    func getDateFormatted(date: Date) -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "MM/dd"

        return dateFormatter.string(from: date)
    }

    func getCurrentWeekDatesFormatted(date: Date) -> [String] {
        let calendar = Calendar.current
        let currentDate = date

        // Find the start of the current week (Monday)
        let startOfWeekComponents = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)
        let startDate = calendar.date(from: startOfWeekComponents)!

        // Find the end of the current week (Sunday)
        let endOfWeekComponents = DateComponents(day: 6)
        let endDate = calendar.date(byAdding: endOfWeekComponents, to: startDate)!

        // Generate an array of formatted date strings for the current week
        var weekDatesFormatted: [String] = []
        var currentDatePointer = startDate

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"

        while currentDatePointer <= endDate {
            weekDatesFormatted.append(dateFormatter.string(from: currentDatePointer))
            currentDatePointer = calendar.date(byAdding: .day, value: 1, to: currentDatePointer)!
        }

        return weekDatesFormatted
    }

    func mealsForTheWeek(date: Date?) -> [Meal] {
        var predicates = [NSPredicate]()


        let days = getCurrentWeekDatesFormatted(date: date ?? Date())

        let datePredicate = NSPredicate(format:"day IN %@", days)

        predicates.append(datePredicate)

        let request = Meal.fetchRequest()
//        request.predicate = datePredicate


        let allMeals = (try? container.viewContext.fetch(request)) ?? []
        return allMeals.sorted()
    }

    func mealsForTheDay(day: String) -> [Meal] {
        var predicates = [NSPredicate]()

        let datePredicate = NSPredicate(format:"day CONTAINS[c] %@", day)

        predicates.append(datePredicate)

        let request = Meal.fetchRequest()
        request.predicate = datePredicate


        let allMeals = (try? container.viewContext.fetch(request)) ?? []

        return allMeals.sorted()
    }

    func changeSize() {
        if columnSize == 100 {
            columnSize = 150
        } else if columnSize == 150 {
            columnSize = 200
        } else {
            columnSize = 100
        }
    }
}
