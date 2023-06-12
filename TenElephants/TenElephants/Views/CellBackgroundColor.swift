import Foundation
import UIKit

extension UIColor {
    static var cellBackgroundColor: UIColor {
        UIColor { traits -> UIColor in
            traits.userInterfaceStyle == .dark ? .secondarySystemBackground : .systemBackground
        }
    }
}
