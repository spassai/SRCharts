import Foundation

/// RadarChartView를 그리기 위한 데이터
open class RadarData: NSObject, Identifiable {
    public let id: UUID
    
    /// 지표 이름
    public var name: String

    /// 지표 값
    public var value: Double
    
    var radius: Double
    var point: CGPoint
    var angle: Double
    
    /// Class 초기화
    ///
    /// - Parameters:
    ///   - name: 지표 이름
    ///   - value: 지표 값

    public init(name: String, value: Double) {
        self.id = UUID()
        self.name = name
        self.value = value
        self.radius = 0
        self.point = .zero
        self.angle = 0
    }
}
