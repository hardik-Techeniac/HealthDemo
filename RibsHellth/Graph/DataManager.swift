//
//  DataManager.swift
//  RibsHellth
//
//  Created by Hardik's Mac on 22/11/21.
//

import Foundation
import RxSwift
import Charts
import RxCocoa

enum SegmentType
{
    case day
    case months
    case week
}
let DataManager = GraphDataManager.sharedInstance
class GraphDataManager:NSObject
{
    static let sharedInstance = GraphDataManager()
    var WeekDays = ["MON","TUE","WED","THU","FRI","SAT","SUN"]
    var days = ["08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00"]
    var Months = (0..<30).map { (i) -> String in
        return String(format: "%02d", i)
    }
    var Staps = 1
    // MARK: Fetch All Data in Model
    class func fetchAllDayGraphData() -> Observable<[ChartModel]>
    {
        return Observable<[ChartModel]>.create { observer  in
            let Chart = [
                ChartModel(mLineData: generateLineData(selectedType: .day), mBarData: generateBarData(selectedType: .day), mPieData: generatePieData(), YAxis: GraphDataManager().days,steps: DataManager.Staps),
                ChartModel(mLineData: generateLineData(selectedType: .week), mBarData: generateBarData(selectedType: .week), mPieData: generatePieData(), YAxis: GraphDataManager().WeekDays,steps: DataManager.Staps),
                ChartModel(mLineData: generateLineData(selectedType: .months), mBarData: generateBarData(selectedType: .months), mPieData: generatePieData(), YAxis: GraphDataManager().Months,steps: DataManager.Staps)]
            observer.onNext(Chart)
            return Disposables.create()
        }
    }
 // MARK: Create Linechart dummy data
    class func generateLineData(selectedType: SegmentType) -> LineChartData {
        var Count = Int()
        var StartValue =  Int()
        var StopValue =  Int()
        DataManager.Staps = 0
        switch selectedType
        {
        case .day:
            Count = GraphDataManager().days.count
            StartValue = 100
            StopValue = 300
            break
        case .months:
            Count = GraphDataManager().Months.count
            StartValue = 100
            StopValue = 500
            break
        case .week:
            Count = GraphDataManager().WeekDays.count
            StartValue = 100
            StopValue = 500
            break
        }
        let Lineentries = (0..<Count).map { (i) -> ChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(Int.random(in: StartValue...StopValue)))
        }
        let set = LineChartDataSet(entries: Lineentries, label: "Runtime")
        set.setColor(UIColor(red: 247/255, green: 159/255, blue: 51/255, alpha: 1))
        set.lineWidth = 2.5
        set.setCircleColor(UIColor.red)
        set.circleRadius = 5
        set.circleHoleRadius = 2.5
        set.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        set.mode = .cubicBezier
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        set.mode = .linear
        set.axisDependency = .left
        
        return LineChartData(dataSet: set)
    }

 // MARK: Create Barchart dummy data
    class func generateBarData(selectedType:SegmentType) -> BarChartData {
        var Count = Int()
        var StartValue =  Int()
        var StopValue =  Int()
        DataManager.Staps = 0
        switch selectedType
        {
        case .day:
            Count = GraphDataManager().days.count
            StartValue = 100
            StopValue = 1000
            break
        case .months:
            Count = GraphDataManager().Months.count
            StartValue = 500
            StopValue = 1000
            break
        case .week:
            Count = GraphDataManager().WeekDays.count
            StartValue = 300
            StopValue = 2000
            break
        }
        let  Barentries = (0..<Count).map { (i) -> ChartDataEntry in
            let YAxis = Double.random(in: Double(StartValue)...Double(StopValue))
            DataManager.Staps = DataManager.Staps + Int(YAxis)
            return BarChartDataEntry(x: Double(i), y: YAxis)
            
        }
        let set1 = BarChartDataSet(entries: Barentries, label: "Steps")
        set1.setColor(UIColor(red:99/255, green: 162/255, blue: 251/255, alpha: 1))
        set1.valueTextColor = .clear
        set1.valueFont = .systemFont(ofSize: 10)
        set1.axisDependency = .left
        let groupSpace = 0.06
        let barSpace = 0.02 // x2 dataset
        let barWidth = 0.5 // x2 dataset
        // (0.45 + 0.02) * 2 + 0.06 = 1.00 -> interval per "group"
        var dataSets = [BarChartDataSet]()
        dataSets.append(set1)
        let data = BarChartData(dataSets: dataSets)
        data.barWidth = barWidth
        // make this BarData object grouped
        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        return data
    }
    
// MARK: Create Piechart dummy data
    class func generatePieData() -> PieChartData {
        let PieChartName =  ["Jog","Run","Climb"]
        let entries = (0..<PieChartName.count).map { (i) -> ChartDataEntry in
            return PieChartDataEntry(value: Double(arc4random_uniform(5) + 10 / 5), label: PieChartName[i])
        }
        // Title
        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2
        
        set.colors = [UIColor(red: 247/255, green: 159/255, blue: 51/255, alpha: 1),UIColor(red: 99/255, green: 162/255, blue: 251/255, alpha: 1),UIColor(red: 104/255, green: 145/255, blue: 199/255, alpha: 1)]
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setDrawValues(false)
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.black)
        return data
    }
}
