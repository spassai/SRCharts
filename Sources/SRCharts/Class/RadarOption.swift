import Foundation
import SwiftUI

/// 지표 표현 옵션
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
open class IndicatorStyle {
    var size: Double
    var color: Color
    var weight: Font.Weight
    var padding: Double
    var lineStyle: LineStyle
    
    /// Constructor of IndicatorStyle
    ///
    /// - Parameters:
    ///   - size: 지표 폰트 크기
    ///   - color: 지표의 폰트 색상
    ///   - weight: 지표의 폰트 굵기
    ///   - padding: 지표 글자와 가이드라인과의 간격
    ///   - lineStyle: 지표 선 옵션
    public init(size: Double? = 15, color: Color? = .white, weight: Font.Weight? = .bold, padding: Double? = 10, lineStyle: LineStyle? = LineStyle()) {
        self.size = size!
        self.color = color!
        self.weight = weight!
        self.padding = padding!
        self.lineStyle = lineStyle!
    }
}

/// 값 표현 옵션
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
open class ValueStyle {
    var size: Double
    var color: Color
    var weight: Font.Weight
    var show: Bool
    var showPointer: Bool
    var lineStyle: LineStyle
    var fill: Bool
    var fillColor: Color?
    var fillOpacity: Double
    
    /// Constructor of ValueStyle
    ///
    /// - Parameters:
    ///   - size: 값 폰트 크기
    ///   - color: 값의 폰트 색상
    ///   - weight: 값의 폰트 굵기
    ///   - show: 값의 글자 표시 유무 - ``Boolean``
    ///   - showPointer: 값의 Pointer 표시 유무 - ``Boolean``
    ///   - lineStyle: 값 연결 선 옵션
    ///   - fill: 값 연결 후 채우기 유무
    ///   - fillColor: 채우기 색상 - 생략시 선의 색상에 따라 자동으로 색상이 결정됨
    ///   - fillOpacity: 채우기 투명도
    public init(size: Double? = 9, color: Color? = .white, weight: Font.Weight? = .bold, show: Bool? = true, showPointer: Bool? = true, lineStyle: LineStyle? = LineStyle(), fill: Bool? = true, fillColor: Color? = nil, fillOpacity: Double? = 0.1) {
        self.size = size!
        self.color = color!
        self.weight = weight!
        self.show = show!
        self.showPointer = showPointer!
        self.lineStyle = lineStyle!
        self.fill = fill!
        self.fillColor = fillColor
        self.fillOpacity = fillOpacity!
    }
}

/// 선 표현 옵션
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
open class LineStyle {
    public enum LineType {
        case circle
        case linear
    }
    var show: Bool
    var type: LineType
    var lineWidth: Double
    var color: Color
    
    /// Constructor of LineStyle
    ///
    /// - Parameters:
    ///   - show: 선 표시 유무 - ``Boolean``
    ///   - type: 선의 형태 - .circle: 원형, .linear: 직선형
    ///   - lineWidth: 선의 굵기
    ///   - color: 선의 색상
    public init(show: Bool? = true, type: LineType? = .circle, lineWidth: Double? = 1, color: Color? = .gray) {
        self.show = show!
        self.type = type!
        self.lineWidth = lineWidth!
        self.color = color!
    }
}

/// RadarChart를 그리기 위한 옵션
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
open class RadarOption {
    var padding: Double
    var maxValue: Double?
    
    var indicatorStyle: IndicatorStyle
    var valueStyle: ValueStyle
    var guideLineStyle: LineStyle

    /// Constructor of RadarOption
    ///
    /// - Parameters:
    ///   - padding: 전체 차트의 padding 값 (기본 30)
    ///   - maxValue: 지표 값의 최대 값 (생략시 전체 제표 값들의 최대값이 자동으로 설정됨)
    ///   - indicatorStyle: 지표의 스타일
    ///   - valueStyle: 지표 값의 스타일
    ///   - guideLineStyle: 가이드라인의 스타일
    public init(padding: Double? = 30, maxValue: Double? = nil, indicatorStyle: IndicatorStyle? = IndicatorStyle(), valueStyle: ValueStyle? = ValueStyle(lineStyle: LineStyle(color: .green)), guideLineStyle: LineStyle? = LineStyle() ) {
        self.maxValue = maxValue
        self.padding = padding!
        self.indicatorStyle = indicatorStyle!
        self.valueStyle = valueStyle!
        self.guideLineStyle = guideLineStyle!
    }
}
