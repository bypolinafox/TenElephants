import Foundation

protocol RecentsProviderProtocol {
    typealias MealsCompletion = (Result<Meals, NetworkFetchingError>) -> Void

    func getRecentMeals(completion: @escaping MealsCompletion)
}
