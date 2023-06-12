import Foundation

enum MealsDataProviderErrors: Error {
    case unableToMakeRequest
    case noResponseData
    case unparsableData
    case serverError(error: Error)
}

protocol MealsDataProvider {
    typealias MealsFetchCompletion = (Result<Meals, MealsDataProviderErrors>) -> Void
    typealias CocktailFetchCompletion = (Result<Drinks, MealsDataProviderErrors>) -> Void

    func fetchRandomPreviewMeals(completionHandler: @escaping MealsFetchCompletion)
    func fetchMealDetails(by id: String, completionHandler: @escaping MealsFetchCompletion)
    func fetchMealListFiltered(
        by ingredient: String,
        completionHandler: @escaping MealsFetchCompletion
    )
    func fetchMealListFiltered(
        by ingredients: [String],
        completionHandler: @escaping MealsFetchCompletion
    )
    func fetchLatestMeals(completionHandler: @escaping MealsFetchCompletion)
    func searchMealByName(name: String, completionHandler: @escaping MealsFetchCompletion)
    func fetchRandomCocktail(completionHandler: @escaping CocktailFetchCompletion)
}
