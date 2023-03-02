import Foundation
import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct RadarChartValueText: View {
    var data: [RadarData]
    var points: [CGPoint]
    var center: CGPoint
    var radius: Double
    var valueStyle: ValueStyle

    @Environment(\.lineStyle) var lineStyle
    
    var body: some View {
        if self.valueStyle.show && points.count >= data.count {
            ForEach(data.indices, id: \.self) { index in
                Text(data[index].value.roundedString(digit: 2))
                    .fontWeight(self.valueStyle.weight)
                    .foregroundColor(self.valueStyle.color)
                    .font(.system(size: self.valueStyle.size))
                    .position(points[index] * radius + center - CGPoint(x: 0, y: 13))
                
                if self.valueStyle.showPointer {
                    Circle()
                        .strokeBorder(lineStyle.color, lineWidth: lineStyle.lineWidth)
                        .frame(width: 6, height: 6)
                        .position(points[index] * radius + center)
                }
            }
        }
    }
}
