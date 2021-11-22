//
//  GraphViewController.swift
//  RibsHellth
//
//  Created by Hardik's Mac on 19/11/21.
//

import RIBs
import RxSwift
import UIKit
import Charts
import RxCocoa
protocol GraphPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    var graphModel: BehaviorRelay<[ChartModel]> { get }
}

final class GraphViewController: UIViewController, GraphPresentable, GraphViewControllable, ChartViewDelegate {
    weak var listener: GraphPresentableListener?
    @IBOutlet weak var PieGraph: PieChartView!
    @IBOutlet weak var CombinedChart: CombinedChartView!
    @IBOutlet weak var lblStaps: UILabel!
    @IBOutlet weak var segMonthdata: UISegmentedControl!
    @IBOutlet weak var lblToday: UILabel!
    var PieChartData1 = [PieChartDataEntry]()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        print("VDL :- GraphViewController")
        self.title = "Steps"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 98/255, green: 162/255, blue: 252/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 98/255, green: 162/255, blue: 252/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.setupPieChart(chartView: PieGraph)
        self.PieGraph.delegate = self
        self.CombinedChart.delegate = self
        SetupCombineChart(chartView: self.CombinedChart)
        self.setChartData()
        incrementLabel(to: 4297)
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    // MARK: Segment controll action when change
    @IBAction func segAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0
        {
            self.setChartData()
            self.lblToday.text = "Today"
        }
        else if sender.selectedSegmentIndex == 1
        {
            self.setChartData()
            self.lblToday.text = "7 Days"
        }
        else if sender.selectedSegmentIndex == 2
        {
            self.setChartData()
            self.lblToday.text = "30 Days"
        }
        
    }
    // MARK: Setup Combine Chart Settings
    func setupPieChart(chartView: PieChartView)
    {
        chartView.usePercentValuesEnabled = false
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.drawEntryLabelsEnabled = false
        
        chartView.holeRadiusPercent = 0.48
        chartView.transparentCircleRadiusPercent = 0.61
        chartView.chartDescription?.enabled = false
        chartView.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
        chartView.legend.enabled = false
        chartView.drawCenterTextEnabled = true
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true
        
        let l = chartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.xEntrySpace = 500
        l.yEntrySpace = 0
        l.yOffset = 0
        chartView.isUserInteractionEnabled = false
    }
    // MARK: Setup Combine Chart Settings
    func SetupCombineChart(chartView: CombinedChartView)
    {
        chartView.delegate = self
        chartView.drawBarShadowEnabled = false
        chartView.highlightFullBarEnabled = false
        
        
        chartView.drawOrder = [DrawOrder.bar.rawValue,
                               DrawOrder.bubble.rawValue,
                               DrawOrder.candle.rawValue,
                               DrawOrder.line.rawValue,
                               DrawOrder.scatter.rawValue]
        
        let l = chartView.legend
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        
        let rightAxis = chartView.rightAxis
        rightAxis.axisMinimum = 0
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bothSided
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        xAxis.valueFormatter = self
        
        
    }
    // MARK: Set chart data
    func setChartData() {
        let data = CombinedChartData()
        data.barData = self.listener?.graphModel.value[segMonthdata.selectedSegmentIndex].mBarData
        data.lineData = self.listener?.graphModel.value[segMonthdata.selectedSegmentIndex].mLineData
        self.PieGraph.data = self.listener?.graphModel.value[segMonthdata.selectedSegmentIndex].mPieData
        self.CombinedChart.xAxis.axisMaximum = data.xMax + 0.25
        self.CombinedChart.data = data
        self.CombinedChart.data?.highlightEnabled = false
        self.CombinedChart.animate(yAxisDuration: 1.4)
        self.CombinedChart.setExtraOffsets(left: 5, top: 5, right: 5, bottom: 15)
        incrementLabel(to: self.listener?.graphModel.value[segMonthdata.selectedSegmentIndex].steps ?? 0)
        
        
    }
    
}
extension GraphViewController:IAxisValueFormatter
{
    // MARK: Set yaxisName by passing Array
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let Yaxiscount = self.listener?.graphModel.value[segMonthdata.selectedSegmentIndex].YAxis
        return Yaxiscount![Int(value) % Yaxiscount!.count]
    }
    
}

extension GraphViewController
{
    func incrementLabel(to endValue: Int) {
        let duration: Double = 0.5 //seconds
        DispatchQueue.global().async {
            var startvalue = 0
            startvalue = endValue / 4
            for i in startvalue ..< (endValue + 1) {
                let sleepTime = UInt32(duration/Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.lblStaps.text = "\(i)"
                }
            }
        }
    }
}
