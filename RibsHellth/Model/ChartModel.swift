//
//  ChartModel.swift
//  RibsHellth
//
//  Created by Hardik's Mac on 22/11/21.
//

import Foundation
import Charts

struct ChartModel {
    // TODO: mLineData for LineChart - mBarData for Barchart - mPieData fir Piechart data
    let mLineData :LineChartData
    let mBarData : BarChartData
    let mPieData : PieChartData
    let YAxis:[String]
    let steps : Int
    
}
