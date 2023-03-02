import Foundation
import SwiftUI

extension CGPoint{
    func getPositionByAngle(angle: Double, radius: Double) -> CGPoint {
        let addAngle: Double = angle + 270
        return CGPoint(x: cos(addAngle.toRadians()) * radius + self.x, y: sin(addAngle.toRadians()) * radius + self.y)
    }
    
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    func translate(x: CGFloat, _ y: CGFloat) -> CGPoint {
        return CGPointMake(self.x + x, self.y + y)
    }
    
    func translateX(x: CGFloat) -> CGPoint {
        return CGPointMake(self.x + x, self.y)
    }
    
    func translateY(y: CGFloat) -> CGPoint {
        return CGPointMake(self.x, self.y + y)
    }
    
    func invertY() -> CGPoint {
        return CGPointMake(self.x, -self.y)
    }
    
    func xAxis() -> CGPoint {
        return CGPointMake(0, self.y)
    }
    
    func yAxis() -> CGPoint {
        return CGPointMake(self.x, 0)
    }
    
    func length() -> CGFloat {
        return CGFloat(sqrt(CDouble(
            self.x * self.x + self.y * self.y
            )))
    }

    func normalize() -> CGPoint {
        let l = self.length()
        return CGPointMake(self.x / l, self.y / l)
    }
    
    func getControl(p2: CGPoint, p3: CGPoint, d1: CGFloat, d2: CGFloat, alpha: CGFloat = 1) -> CGPoint {
        var result = p3 * pow(d1, 2 * alpha)
        var t1 = 2 * pow(d1, 2 * alpha)

        t1 = t1 + 3 * pow(d1, alpha) * pow(d2, alpha)
        t1 = t1 + pow(d2, 2 * alpha)

        result = result - self * pow(d2, 2 * alpha)
        result = result + p2 * t1
        result = result * (1.0 / (3 * pow(d1, alpha) * (pow(d1, alpha) + pow(d2, alpha))))

        return result
    }
}
