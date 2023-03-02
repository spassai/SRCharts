import Foundation
import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct RadarChartValueView: View {
    var points: [CGPoint]
    var center: CGPoint
    var radius: Double
    var valueStyle: ValueStyle
    
    @Environment(\.fillColor) var fillColor
    @Environment(\.lineStyle) var lineStyle

    init(points: [CGPoint], center: CGPoint, radius: Double, valueStyle: ValueStyle) {
        self.points = points.map { point in
            return point * radius + center
        }
        self.center = center
        self.radius = radius
        self.valueStyle = valueStyle
    }
    
    var body: some View {
        ZStack {
            if points.count > 0 {
                let shapeFillColor = self.fillColor ?? self.lineStyle.color

                ValuePathShape(points: points, type: self.lineStyle.type)
                    .fill(shapeFillColor.opacity(self.valueStyle.fillOpacity), strokeBorder: lineStyle.color, lineWidth: lineStyle.lineWidth)
            }
        }
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct ValuePathShape: Shape {
    var points: [CGPoint]
    var type: LineStyle.LineType
    
    init(points: [CGPoint], type: LineStyle.LineType) {
        self.points = points
        self.type = type
    }

    var animatableData: ValuePathVector {
        get {
            .init(points: points.map { CGPoint.AnimatableData($0.x, $0.y)})
        }
        set {
            points = newValue.points.map { CGPoint(x: $0.first, y: $0.second)}
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let alpha: CGFloat = 0.2

        guard points.count > 1 else { return path }
        
        path.move(to: points[0])

        for index in 0..<points.count {
            let p0 = points[circularIndex: index - 1]
            let p1 = points[circularIndex: index]
            let p2 = points[circularIndex: index + 1]
            let p3 = points[circularIndex: index + 2]

            if type == .circle {
                let d1 = (p1 - p0).length()
                let d2 = (p2 - p1).length()
                let d3 = (p3 - p2).length()
                
                let b1 = p0.getControl(p2: p1, p3: p2, d1: d1, d2: d2, alpha: alpha)
                let b2 = p3.getControl(p2: p2, p3: p1, d1: d3, d2: d2, alpha: alpha)
                
                path.addCurve(to: p2, control1: b1, control2: b2)
            }
            else {
                path.addLine(to: p2)
            }
        }

        return path
    }
}
