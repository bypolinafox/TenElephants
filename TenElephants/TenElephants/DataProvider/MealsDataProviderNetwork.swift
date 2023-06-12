import Foundation
import NetWorkerLibrary

final class MealsDataProviderNetwork: MealsDataProvider {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchRandomPreviewMeals(completionHandler: @escaping MealsFetchCompletion) {
        networkService.getRandomMeals { result in
            switch result {
            case let .success(meals):
                completionHandler(.success(meals))
            case let .failure(error):
                completionHandler(.failure(error.mealProviderError))
            }
        }
    }

    func fetchRandomCocktail(completionHandler: @escaping CocktailFetchCompletion) {
        networkService.getRandomCocktails { result in
            switch result {
            case let .success(meals):
                completionHandler(.success(meals))
            case let .failure(error):
                completionHandler(.failure(error.mealProviderError))
            }
        }
    }

    func fetchMealDetails(by id: String, completionHandler: @escaping MealsFetchCompletion) {
        networkService.getMealDetails(id: id) { result in
            switch result {
            case let .success(meals):
                completionHandler(.success(meals))
            case let .failure(error):
                completionHandler(.failure(error.mealProviderError))
            }
        }
    }

    func fetchMealListFiltered(
        by ingredient: String,
        completionHandler: @escaping MealsFetchCompletion
    ) {
        networkService.getFilteredMealList(ingredient: ingredient) { result in
            switch result {
            case let .success(meals):
                completionHandler(.success(meals))
            case let .failure(error):
                completionHandler(.failure(error.mealProviderError))
            }
        }
    }

    func fetchMealListFiltered(
        by ingredients: [String],
        completionHandler: @escaping MealsFetchCompletion
    ) {
        networkService.getFilteredMealList(ingredients: ingredients) { result in
            switch result {
            case let .success(meals):
                completionHandler(.success(meals))
            case let .failure(error):
                completionHandler(.failure(error.mealProviderError))
            }
        }
    }

    func fetchLatestMeals(completionHandler: @escaping MealsFetchCompletion) {
        networkService.getLatestMeals { result in
            switch result {
            case let .success(meals):
                completionHandler(.success(meals))
            case let .failure(error):
                completionHandler(.failure(error.mealProviderError))
            }
        }
    }

    func searchMealByName(name: String, completionHandler: @escaping MealsFetchCompletion) {
        networkService.searchMealByName(name: name) { result in
            switch result {
            case let .success(meals):
                completionHandler(.success(meals))
            case let .failure(error):
                completionHandler(.failure(error.mealProviderError))
            }
        }
    }
}

extension NetWorkerFetchingError {
    var mealProviderError: MealsDataProviderErrors {
        switch self {
        case .unableToMakeRequest:
            return .unableToMakeRequest
        case .noResponseData:
            return .noResponseData
        case .parsingError:
            return .unparsableData
        case let .serverError(e):
            return .serverError(error: e)
        }
    }
}
