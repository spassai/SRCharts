import Foundation
import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension GraphicsContext {
    func drawLineByAngleOfCircle(angle: Double, radius: Double, center: CGPoint, with shading: GraphicsContext.Shading = GraphicsContext.Shading.color(.black), lineWidth: CGFloat = 1) {
        let position = center.getPositionByAngle(angle: angle, radius: radius)
        
        self.drawLine(from: center, to: position, with: shading, lineWidth: lineWidth)
    }

    func drawLine(from: CGPoint, to: CGPoint, with shading: GraphicsContext.Shading = GraphicsContext.Shading.color(.black), lineWidth: CGFloat = 1) {
        self.stroke(
            Path { path in
                path.move(to: from)
                path.addLine(to: to)
            }, with: shading, lineWidth: lineWidth
        )
    }
    
    func drawCircle(center: CGPoint, radius: Double, with shading: GraphicsContext.Shading = GraphicsContext.Shading.color(.black), lineWidth: CGFloat = 1 ) {
        self.stroke(
            Path(ellipseIn: CGRect(origin: CGPoint(x: center.x - radius, y: center.y - radius), size: CGSize(width: radius * 2, height: radius * 2))),
            with: shading,
            lineWidth: lineWidth
        )
    }
}
