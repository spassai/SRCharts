import Foundation
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    public func indicatorLineStyle(type: LineStyle.LineType = .circle, color: Color = .secondary, lineWidth: Double = 1) -> some View {
        self.modifier(IndicatorLineStyleModifier(indicatorLineStyle: LineStyle(color: color, lineWidth: lineWidth)))
    }

    public func guidelineStyle(type: LineStyle.LineType = .circle, color: Color = .secondary, lineWidth: Double = 1) -> some View {
        self.modifier(GuidelineStyleModifier(guidelineStyle: LineStyle(type: type, color: color, lineWidth: lineWidth)))
    }

    public func fillColor(_ value: Color) -> some View {
        self.modifier(FillColorModifier(fillColor: value))
    }
    
    public func lineStyle(type: LineStyle.LineType = .circle, color: Color = .secondary, lineWidth: Double = 1) -> some View {
        self.modifier(LineStyleModifier(lineStyle: LineStyle(type: type, color: color, lineWidth: lineWidth)))
    }
}
