import Foundation
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct GuidelineStylePropertyKey: EnvironmentKey {
    typealias Value = LineStyle

    static var defaultValue: LineStyle = LineStyle()
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {
    var guidelineStyle: LineStyle {
        get { self[GuidelineStylePropertyKey.self] }
        set { self[GuidelineStylePropertyKey.self] = newValue }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct GuidelineStyleModifier: ViewModifier {
    let guidelineStyle: LineStyle
    
    func body(content: Content) -> some View {
        content
            .environment(\.guidelineStyle, guidelineStyle)
    }
}
