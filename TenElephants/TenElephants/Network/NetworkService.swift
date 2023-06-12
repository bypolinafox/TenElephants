import Foundation
import NetWorkerLibrary

final class NetworkService: NetworkServiceProtocol {
    private lazy var mealsNetWorkerService = NetWorkerService(host: NetworkKeys.mealHost)
    private lazy var drinksNetWorkerService = NetWorkerService(host: NetworkKeys.drinkHost)
    
    func getMealDetails(id: String, completion: @escaping MealsCompletion) {
        mealsNetWorkerService.perform(
            type: .GET,
            path: makePath(path: "lookup"),
            params: ["i": id],
            completion: completion
        )
    }

    func getRandomMeals(completion: @escaping MealsCompletion) {
        mealsNetWorkerService.perform(
            type: .GET,
            path: makePath(path: "randomselection"),
            params: [:],
            completion: completion
        )
    }

    func getRandomCocktails(completion: @escaping CocktailCompletion) {
        drinksNetWorkerService.perform(
            type: .GET,
            path: makePath(path: "random"),
            params: [:],
            completion: completion
        )
    }

    func getFullIngredientsList(
        completion: @escaping (Result<FullIngredients,NetWorkerFetchingError>) -> Void
    ) {
        mealsNetWorkerService.perform(
            type: .GET,
            path: makePath(path: "list"),
            params: ["i": "list"],
            completion: completion
        )
    }

    func getFilteredMealList(ingredient: String, completion: @escaping MealsCompletion) {
        mealsNetWorkerService.perform(
            type: .GET,
            path: makePath(path: "filter"),
            params: ["i": ingredient],
            completion: completion
        )
    }

    func getFilteredMealList(ingredients: [String], completion: @escaping MealsCompletion) {
        mealsNetWorkerService.perform(
            type: .GET,
            path: makePath(path: "filter"),
            params: ["i": ingredients.joined(separator: ",")],
            completion: completion
        )
    }

    func searchMealByName(name: String, completion: @escaping MealsCompletion) {
        mealsNetWorkerService.perform(
            type: .GET,
            path: makePath(path: "search"),
            params: ["s": name],
            completion: completion
        )
    }

    func getLatestMeals(completion: @escaping MealsCompletion) {
        mealsNetWorkerService.perform(
            type: .GET,
            path: makePath(path: "latest"),
            params: [:],
            completion: completion
        )
    }

    private func makePath(path: String) -> String {
        return "/api/json/v2/\(NetworkKeys.apiKey)/\(path).php"
    }
}

fileprivate enum NetworkKeys {
    static let drinkHost: String = "www.thecocktaildb.com"
    static let mealHost: String = "www.themealdb.com"
    static let apiKey: Int = 9_973_533
}
