import Foundation

extension Double {
    func toRadians() -> Double {
        return self * (Double.pi) / 180
    }
    
    func getPercent(max: Double) -> Double {
        return 1 - (max - self) / max
    }
    
    func roundedString(digit: Int = 0) -> String {
        if(digit == 0) {
            return String(Int(self))
        }
        
        let result: Double = self * Double(digit * 10)
        
        return String(result.rounded() / Double(digit * 10))
    }

}
