import Foundation
import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct RadarChartIndicatorView: View {
    let data: [IndicatorData]
    let center: CGPoint
    let radius: Double
    let indicatorStyle: IndicatorStyle
    
    @Environment(\.indicatorLineStyle) var indicatorLineStyle
    
    init (data: [IndicatorData], center: CGPoint, radius: Double, indicatorStyle: IndicatorStyle) {
        self.data = data
        self.center = center
        self.radius = radius
        self.indicatorStyle = indicatorStyle
    }
    
    var body: some View {
        ZStack {
            ForEach(self.data) { indicator in
                Path { path in
                    path.move(to: self.center)
                    path.addLine(to: self.center.getPositionByAngle(angle: indicator.angle, radius: radius))
                }
                .stroke(self.indicatorLineStyle.color, lineWidth: self.indicatorLineStyle.lineWidth)
                
                Text(indicator.name)
                    .fontWeight(self.indicatorStyle.weight)
                    .foregroundColor(self.indicatorStyle.color)
                    .font(.system(size: self.indicatorStyle.size))
                    .position(self.center.getPositionByAngle(angle: indicator.angle, radius: self.radius + self.indicatorStyle.padding + 10))
            }
        }
    }
}
