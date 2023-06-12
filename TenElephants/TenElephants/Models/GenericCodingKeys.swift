import Foundation

final class GenericCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?

    required init?(stringValue: String) {
        self.stringValue = stringValue
    }

    required init?(intValue: Int) {
        self.intValue = intValue
        stringValue = "\(intValue)"
    }
}
