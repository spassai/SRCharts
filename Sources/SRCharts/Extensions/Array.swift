import Foundation

extension Array {
    subscript(circularIndex index: Int) -> Element {
        get {
            assert(self.count > 0)
            let index = (index + self.count) % self.count
            return self[index]
        }
        set {
            assert(self.count > 0)
            let index = (index + self.count) % self.count
            return self[index] = newValue
        }
    }
    func circularIndex(_ index: Int) -> Int {
        return (index + self.count) % self.count
    }
}
