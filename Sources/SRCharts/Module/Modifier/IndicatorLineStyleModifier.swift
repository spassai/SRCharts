import Foundation
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct IndicatorLineStylePropertyKey: EnvironmentKey {
    typealias Value = LineStyle

    static var defaultValue: LineStyle = LineStyle()
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {
    var indicatorLineStyle: LineStyle {
        get { self[IndicatorLineStylePropertyKey.self] }
        set { self[IndicatorLineStylePropertyKey.self] = newValue }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct IndicatorLineStyleModifier: ViewModifier {
    let indicatorLineStyle: LineStyle
    
    func body(content: Content) -> some View {
        content
            .environment(\.indicatorLineStyle, indicatorLineStyle)
    }
}
