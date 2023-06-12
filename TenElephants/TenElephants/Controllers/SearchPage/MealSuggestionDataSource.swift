import Foundation
import UIKit

final class MealSuggestionDataSource: NSObject, UICollectionViewDataSource {
    private enum Constants {
        static let bottomInset: CGFloat = 10
    }

    private let cellWidth: CGFloat
    private let cellID: String
    private let imageLoader: ImageLoader

    private let openMealPageController: (Meal) -> Void

    var meals = [Meal]()

    init(
        cellWidth: CGFloat,
        cellID: String,
        imageLoader: ImageLoader,
        openSingleMeal: @escaping (Meal) -> Void
    ) {
        self.cellWidth = cellWidth
        self.cellID = cellID
        self.imageLoader = imageLoader
        self.openMealPageController = openSingleMeal
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        min(meals.count, 10) // can't be more than 10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        guard let suggestionCell = cell as? WideCellView else { return cell }
        suggestionCell.clipsToBounds = false
        suggestionCell.layer.masksToBounds = false

        let meal = meals[indexPath.row]
        suggestionCell.configure(
            titleText: meal.name,
            area: meal.area,
            category: meal.category,
            thumbnailLink: meal.thumbnailLink,
            imageLoader: imageLoader
        )
        return suggestionCell
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meal = meals[indexPath.row]
        openMealPageController(meal)
    }
}

extension MealSuggestionDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt _: IndexPath
    ) -> CGSize {
        CGSize(width: cellWidth, height: collectionView.bounds.height - Constants.bottomInset)
    }
}
