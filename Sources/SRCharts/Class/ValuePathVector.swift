import Foundation
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct ValuePathVector: VectorArithmetic {
    var points: [CGPoint.AnimatableData]

    static func + (lhs: ValuePathVector, rhs: ValuePathVector) -> ValuePathVector {
        return add(lhs: lhs, rhs: rhs, +)
    }
    
    static func - (lhs: ValuePathVector, rhs: ValuePathVector) -> ValuePathVector {
        return add(lhs: lhs, rhs: rhs, -)
    }
    
    static func add(lhs: ValuePathVector, rhs: ValuePathVector, _ sign: (CGFloat, CGFloat) -> CGFloat) -> ValuePathVector {
        let maxPoints = max(lhs.points.count, rhs.points.count)
        let leftIndices = lhs.points.indices
        let rightIndices = rhs.points.indices
        
        var newPoints: [CGPoint.AnimatableData] = []
        (0 ..< maxPoints).forEach { index in
            if leftIndices.contains(index) && rightIndices.contains(index) {
                // Merge points
                let lhsPoint = lhs.points[index]
                let rhsPoint = rhs.points[index]
                newPoints.append(
                    .init(
                        sign(lhsPoint.first, rhsPoint.first),
                        sign(lhsPoint.second, rhsPoint.second)
                    )
                )
            } else if rightIndices.contains(index), let lastLeftPoint = lhs.points.last {
                // Right side has more points, collapse to last left point
                let rightPoint = rhs.points[index]
                newPoints.append(
                    .init(
                        sign(lastLeftPoint.first, rightPoint.first),
                        sign(lastLeftPoint.second, rightPoint.second)
                    )
                )
            } else if leftIndices.contains(index), let lastPoint = newPoints.last {
                // Left side has more points, collapse to last known point
                let leftPoint = lhs.points[index]
                newPoints.append(
                    .init(
                        sign(lastPoint.first, leftPoint.first),
                        sign(lastPoint.second, leftPoint.second)
                    )
                )
            }
        }
        
        return .init(points: newPoints)
    }
    
    mutating func scale(by rhs: Double) {
        points.indices.forEach { index in
            self.points[index].scale(by: rhs)
        }
    }
    
    var magnitudeSquared: Double {
        return 1.0
    }
    
    static var zero: ValuePathVector {
        return .init(points: [])
    }
}
