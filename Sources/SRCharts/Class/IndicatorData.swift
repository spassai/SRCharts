import Foundation

class IndicatorData : NSObject, Identifiable {
    var id: UUID

    var name: String
    var angle: Double
    
    init(name: String, angle: Double) {
        self.id = UUID()

        self.name = name
        self.angle = angle
    }
}
