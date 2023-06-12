import Foundation

final class RecentsProvider: RecentsProviderProtocol {
    private var recentMeals = Meals(meals: [])

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func getRecentMeals(completion: @escaping (Result<Meals, NetworkFetchingError>) -> Void) {
        networkService.getLatestMeals { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(items):
                self.recentMeals = items
                DispatchQueue.main.async {
                    completion(.success(items))
                }
            case .failure:
                return
            }
        }
    }
}
