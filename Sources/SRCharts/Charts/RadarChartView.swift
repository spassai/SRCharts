import Foundation
import SwiftUI

/// ShockRanger RadarChartView
///
/// SwiftUI의 Path, Circle 등을 사용해서 Radar 형태의 Chart를 그리는 View.
///  - Animation 기능이 추가
///  - colorSchema 대응 (.dark, .light)
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
///                 color: .primary,
///                 weight: .bold,
///                 padding: 10
///             ),
///             valueStyle: ValueStyle(
///                 size: 10,
///                 color: .secondary,
///                 weight: .light,
///                 show: true,
///                 showPointer: true,
///                 fill: true,
///                 fillOpacity: 0.2
///             ),
///         )
///     )
///     .frame(width: 400, height: 400)
///
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct RadarChartView: View {
    var dataSet: [RadarData]
    let options: RadarOption

    @State private var points: [CGPoint]
    @State private var indicatorData: [IndicatorData]
    
    public init(dataSet: [RadarData], options: RadarOption = RadarOption()) {
        self.dataSet = dataSet
        self.options = options
        let maxValue = options.maxValue ?? self.dataSet.map { rader in
            return rader.value
        }.max()
        
        var points: [CGPoint] = []
        for index in 0..<dataSet.count {
            let angle = (360.0 / Double(dataSet.count)) * Double(index)
            let radius = dataSet[index].value.getPercent(max: maxValue!)
            let point = CGPoint(x: 0, y: 0).getPositionByAngle(angle: angle, radius: radius)

            points.append(point)
        }
        self.points = points

        var indicatorData: [IndicatorData] = []
        for index in 0..<self.dataSet.count {
            let angle = (360.0 / Double(dataSet.count)) * Double(index)
            
            indicatorData.append(IndicatorData(name: self.dataSet[index].name, angle: angle))
        }
        self.indicatorData = indicatorData
    }
    
    public var body: some View {
        ZStack {
            GeometryReader { reader in
                let radius: Double = ((reader.size.width < reader.size.height ? Double(reader.size.width) : Double(reader.size.height)) / 2) - options.padding
                let center: CGPoint = CGPoint(x: reader.size.width / 2, y: reader.size.height / 2)
                
                // draw Indicator
                RadarChartIndicatorView(data: self.indicatorData, center: center, radius: radius, indicatorStyle: self.options.indicatorStyle)
                
                // draw GuideLine
                RadarChartGuideLineView(points: points, center: center, radius: radius)
                
                // Draw Chart value area
                RadarChartValueView(points: points, center: center, radius: radius, valueStyle: options.valueStyle)
                
                // Draw Chart value text
                RadarChartValueText(data: dataSet, points: points, center: center, radius: radius, valueStyle: options.valueStyle)
            }
        }
        .onChange(of: dataSet) { newValue in
            updateIndicatorData(dataSet: newValue)
            updateChartValueData(dataSet: newValue)
        }
    }
   
    func updateIndicatorData(dataSet: [RadarData]) {
        var indicatorData: [IndicatorData] = []
        for index in 0..<self.dataSet.count {
            let angle = (360.0 / Double(dataSet.count)) * Double(index)
            
            indicatorData.append(IndicatorData(name: self.dataSet[index].name, angle: angle))
        }
        self.indicatorData = indicatorData
    }

    func updateChartValueData(dataSet: [RadarData]) {
        var points: [CGPoint] = []
        let maxValue = options.maxValue ?? dataSet.map { rader in
            return rader.value
        }.max()

        for index in 0..<dataSet.count {
            let angle = (360.0 / Double(dataSet.count)) * Double(index)
            let radius = dataSet[index].value.getPercent(max: maxValue!)
            let point = CGPoint(x: 0, y: 0).getPositionByAngle(angle: angle, radius: radius)
            
            points.append(point)
        }

        withAnimation {
            self.points = points
        }
    }
}
