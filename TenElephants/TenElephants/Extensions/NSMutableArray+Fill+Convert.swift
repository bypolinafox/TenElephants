import Foundation

extension NSMutableArray {
    func fillWithEmpty(_ count: Int) {
        for idx in 0..<count {
            self.insert("", at: idx)
        }
    }

    func convertToArray() -> [Any] {
        var arr: [Any] = []
        for elem in self {
            arr.append(elem)
        }
        return arr
    }
}
