import Foundation
import NetWorkerLibrary

protocol IngredientsDataProvider {
    func fetchIngredientsList(completionHandler: @escaping (Result<
        IngredientsUIData,
        NetWorkerFetchingError
    >) -> Void)
}
