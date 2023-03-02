import Foundation
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct LineStylePropertyKey: EnvironmentKey {
    typealias Value = LineStyle

    static var defaultValue: LineStyle = LineStyle()
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {
    var lineStyle: LineStyle {
        get { self[LineStylePropertyKey.self] }
        set { self[LineStylePropertyKey.self] = newValue }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct LineStyleModifier: ViewModifier {
    let lineStyle: LineStyle
    
    func body(content: Content) -> some View {
        content
            .environment(\.lineStyle, lineStyle)
    }
}

