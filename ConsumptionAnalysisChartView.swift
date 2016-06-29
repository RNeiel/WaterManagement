//
//  ConsumptionAnalysisChartView.swift
//  WaterManagement
//
//  Created by IE3PMDP000046 on 29/06/16.
//  Copyright © 2016 Honeywell. All rights reserved.
//

import UIKit
import Charts

class ConsumptionAnalysisChartView: UIViewController,ChartViewDelegate {
    
    
   
    @IBOutlet weak var consumptionChart: BarChartView!
    
    let months = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
    
    let dollars1 = [1453.0,2352,5431,1442,5451,6486,1173,5678,9234,1345,9411,2212]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.consumptionChart.delegate = self
        
        setConsumptionChartData(months, values: dollars1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setConsumptionChartData(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Consumption in gallons")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        consumptionChart.data = chartData
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
