import Foundation
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct FillColorPropertyKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {
    var fillColor: Color? {
        get { self[FillColorPropertyKey.self] }
        set { self[FillColorPropertyKey.self] = newValue }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct FillColorModifier: ViewModifier {
    let fillColor: Color?
    
    func body(content: Content) -> some View {
        content
            .environment(\.fillColor, fillColor)
    }
}
