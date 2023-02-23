import SwiftUI

/// ShockRanger RadarChartView
///
/// Canvas를 사용해서 Radar 형태의 Chart를 그리는 View. ``Animation 기능이 없음``
///
/// 기본적인 사용법은 아래와 같음:
///
///     RadarChartView(
///         dataSet: [
///             RadarData(name: "MAP", value: 50.51),
///             RadarData(name: "HR", value: 77.73),
///             RadarData(name: "BT", value: 95.91),
///             RadarData(name: "SPO2", value: 94.00),
///             RadarData(name: "RR", value: 98.44),
///             RadarData(name: "SI", value: 28.24),
///         ],
///         options: RadarOption(
///             padding: 30,
///             maxValue: 100,
///             indicatorStyle: IndicatorStyle(
///                 size: 12,
///                 color: .white,
///                 weight: .bold,
///                 padding: 10,
///                 lineStyle: LineStyle(
///                     show: true,
///                     lineWidth: 1,
///                     color: .gray
///                 )
///             ),
///             valueStyle: ValueStyle(
///                 size: 10,
///                 color: .white,
///                 weight: .bold,
///                 show: true,
///                 showPointer: true,
///                 lineStyle: LineStyle(
///                     show: true,
///                     type: .linear,
///                     lineWidth: 1,
///                     color: .green
///                 ),
///                 fill: true,
///                 fillOpacity: 0.1
///             ),
///             guideLineStyle: LineStyle(
///                 show: true,
///                 type: .linear,
///                 lineWidth: 1,
///                 color: .gray
///             )
///         )
///     )
///     .frame(width: 400, height: 400)
///
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct RadarChartView: View {
    let dataSet: [RadarData]
    let options: RadarOption

    /// Constructor of RadarChartView
    ///
    /// - Parameters:
    ///   - dataSet: 차트를 그리기 위한 데이터 ``Array`` - ``[RadarData]``
    ///   - options: 차트를 그리는 설정값 - RadarOption
    public init(dataSet: [RadarData], options: RadarOption? = nil) {
        self.dataSet = dataSet
        if let options = options {
            self.options = options
        }
        else {
            self.options = RadarOption()
        }
    }
    
    public var body: some View {
        ZStack {
            Canvas { context, size in
                if dataSet.count > 0 {
                    let radius: Double = (size.width < size.height ? Double(size.width) : Double(size.height)) / 2
                    let center: CGPoint = CGPoint(x: size.width / 2, y: size.height / 2)
                    let padding: Double = Double(radius - options.padding) / 5
                    
                    // draw GuideLine
                    drawIndicator(context, center: center, radius: radius)
                    
                    for index in 1...5 {
                        drawGuideLine(context, center: center, radius: radius - options.padding - Double(index - 1) * padding, with: .color(options.guideLineStyle.color), lineWidth: options.guideLineStyle.lineWidth)
                    }
                    
                    drawValueArea(context)
                }
            }
        }
    }
    
    private func drawIndicator(_ context: GraphicsContext, center: CGPoint, radius: Double) {
        let maxValue = options.maxValue ?? dataSet.map { rader in
            return rader.value
        }.max()

        dataSet.enumerated().forEach { index, data in
            let dataRadius: Double = radius - options.padding

            data.angle = (360.0 / Double(dataSet.count)) * Double(index)
            data.radius = dataRadius * data.value.getPercent(max: maxValue!)
            data.point = center.getPositionByAngle(angle: data.angle, radius: data.radius)

            if options.indicatorStyle.lineStyle.show {
                context.drawLineByAngleOfCircle(angle: data.angle, radius: dataRadius, center: center, with: .color(options.indicatorStyle.lineStyle.color), lineWidth: options.indicatorStyle.lineStyle.lineWidth)
            }

            context.draw(
                Text(data.name)
                    .fontWeight(options.indicatorStyle.weight)
                    .foregroundColor(options.indicatorStyle.color)
                    .font(.system(size: options.indicatorStyle.size))
                , at: center.getPositionByAngle(angle: data.angle, radius: radius - options.indicatorStyle.padding)
            )
        }
    }
    
    private func drawGuideLine(_ context: GraphicsContext, center: CGPoint, radius: Double, with shading: GraphicsContext.Shading = GraphicsContext.Shading.color(.black), lineWidth: CGFloat = 1) {
        if options.guideLineStyle.type == .circle {
            context.drawCircle(center: center, radius: radius, with: shading, lineWidth: lineWidth)
        }
        else {
            let path: Path = Path { path in
                let angle = dataSet[0].angle
                let point = center.getPositionByAngle(angle: angle, radius: radius)
                
                path.move(to: point)
                
                for index in 1...dataSet.count {
                    let angle = dataSet[circularIndex: index].angle
                    let point = center.getPositionByAngle(angle: angle, radius: radius)
                    
                    path.addLine(to: point)
                }
            }
            
            context.stroke(path, with: shading, lineWidth: lineWidth)
        }
    }

    private func drawValueArea(_ context: GraphicsContext) {
        let path: Path = Path { path in
            let startIndex = 0
            let endIndex = dataSet.count
            let alpha: CGFloat = 1
        
            path.move(to: dataSet[circularIndex: startIndex].point)

            for i in startIndex ..< endIndex {
                if options.valueStyle.lineStyle.type == .circle {
                    let p0 = dataSet[circularIndex: i - 1].point
                    let p1 = dataSet[circularIndex: i].point
                    let p2 = dataSet[circularIndex: i + 1].point
                    let p3 = dataSet[circularIndex: i + 2].point
                    
                    let d1 = (p1 - p0).length()
                    let d2 = (p2 - p1).length()
                    let d3 = (p3 - p2).length()
                    
                    let b1 = getControl(p1: p0, p2: p1, p3: p2, d1: d1, d2: d2, alpha: alpha)
                    let b2 = getControl(p1: p3, p2: p2, p3: p1, d1: d3, d2: d2, alpha: alpha)
                    
                    path.addCurve(to: p2, control1: b1, control2: b2)
                }
                else {
                    path.addLine(to: dataSet[circularIndex: i].point)
                }
            }
            
            if options.valueStyle.lineStyle.type == .linear {
                path.addLine(to: dataSet[startIndex].point)
            }
        }

        if options.valueStyle.fill {
            var color = Color(
                red: options.valueStyle.lineStyle.color.red(),
                green: options.valueStyle.lineStyle.color.green(),
                blue: options.valueStyle.lineStyle.color.blue(),
                opacity: options.valueStyle.fillOpacity
            )
            
            if let fillColor = options.valueStyle.fillColor {
                color = fillColor.opacity(options.valueStyle.fillOpacity)
            }
            
            context.fill(path, with: .color(color))
        }

        context.stroke(path, with: .color(options.valueStyle.lineStyle.color), lineWidth: options.valueStyle.lineStyle.lineWidth)
        
        dataSet.forEach { data in
            if options.valueStyle.showPointer {
                context.drawCircle(center: data.point, radius: 3, with: .color(options.valueStyle.lineStyle.color), lineWidth: options.valueStyle.lineStyle.lineWidth)
            }
            
            if options.valueStyle.show {
                context.draw(
                    Text(data.value.roundedString(digit: 2))
                        .fontWeight(options.valueStyle.weight)
                        .foregroundColor(options.valueStyle.color)
                        .font(.system(size: options.valueStyle.size))
                    , at: data.point - CGPoint(x: 0, y: 13)
                )
            }
        }
    }
    
    private func getControl(p1: CGPoint, p2: CGPoint, p3: CGPoint, d1: CGFloat, d2: CGFloat, alpha: CGFloat = 1) -> CGPoint {
        var result = p3 * pow(d1, 2 * alpha)
        var t1 = 2 * pow(d1, 2 * alpha)

        t1 = t1 + 3 * pow(d1, alpha) * pow(d2, alpha)
        t1 = t1 + pow(d2, 2 * alpha)

        result = result - p1 * pow(d2, 2 * alpha)
        result = result + p2 * t1
        result = result * (1.0 / (3 * pow(d1, alpha) * (pow(d1, alpha) + pow(d2, alpha))))
        
        return result
    }
}
