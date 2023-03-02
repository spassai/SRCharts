import Foundation
import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct RadarChartGuideLineView: View {
    var points: [CGPoint]
    var center: CGPoint
    var radius: Double

    @Environment(\.guidelineStyle) var guidelineStyle
    
    init(points: [CGPoint], center: CGPoint = .zero, radius: Double = 0) {
        self.points = points
        self.center = center
        self.radius = radius
    }
    
    var body: some View {
        ForEach((1...5).reversed(), id: \.self) { index in
            let drawRadius: Double = radius - Double(index - 1) * (self.radius / 5)

            if guidelineStyle.type == .circle {
                Circle()
                    .strokeBorder(guidelineStyle.color, lineWidth: guidelineStyle.lineWidth)
                    .frame(width: drawRadius * 2, height: drawRadius * 2)
                    .position(center)
            }
            else {
                Path { path in
                    for i in 0...points.count {
                        let angle = (360.0 / Double(points.count)) * Double(i)
                        let point = center.getPositionByAngle(angle: angle, radius: drawRadius)

                        if i == 0 {
                            path.move(to: point)
                        }
                        else {
                            path.addLine(to: point)
                        }
                    }
                }
                .stroke(guidelineStyle.color, lineWidth: guidelineStyle.lineWidth)
            }
        }
    }
}
