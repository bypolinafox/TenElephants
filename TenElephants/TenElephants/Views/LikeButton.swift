import Foundation
import UIKit

final class LikeButton: UIButton {
    private enum Constants {
        static let config = UIImage.SymbolConfiguration(
            pointSize: 30,
            weight: .bold,
            scale: .medium
        )
        static let fillIcon = UIImage(systemName: "heart.fill", withConfiguration: config)
        static let contourIcon = UIImage(systemName: "heart", withConfiguration: config)
        static let activeTint: UIColor = .red
        static let notActiveTint: UIColor = .label
    }

    // достаточно просто выставить isLiked, и кнопка поменяет внешний вид
    var isLiked: Bool {
        didSet {
            updateImage()
        }
    }

    private func updateImage() {
        switch isLiked {
        case true:
            setImage(Constants.fillIcon, for: .normal)
            tintColor = Constants.activeTint
        case false:
            setImage(Constants.contourIcon, for: .normal)
            tintColor = Constants.notActiveTint
        }
    }

    init() {
        isLiked = false
        super.init(frame: .zero)
        updateImage()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
