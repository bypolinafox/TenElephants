import Foundation
import NetWorkerLibrary

protocol NetworkServiceProtocol {
    typealias MealsCompletion = (Result<Meals, NetWorkerFetchingError>) -> Void
    typealias CocktailCompletion = (Result<Drinks, NetWorkerFetchingError>) -> Void

    func getMealDetails(id: String, completion: @escaping MealsCompletion)

    func getRandomMeals(completion: @escaping MealsCompletion)

    func getFullIngredientsList(completion: @escaping (Result<
        FullIngredients,
        NetWorkerFetchingError
    >) -> Void)

    func getFilteredMealList(ingredient: String, completion: @escaping MealsCompletion)

    func getFilteredMealList(ingredients: [String], completion: @escaping MealsCompletion)

    func searchMealByName(name: String, completion: @escaping MealsCompletion)

    func getLatestMeals(completion: @escaping MealsCompletion)

    func getRandomCocktails(completion: @escaping CocktailCompletion)
}

enum NetworkFetchingError: Error {
    case unableToMakeURL
    case noResponseData
    case parsingError
    case serverError(error: Error)
}
