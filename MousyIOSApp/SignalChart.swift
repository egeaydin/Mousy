//
//  AccelerometerChart.swift
//  MousY
//
//  Created by eay on 5/6/17.
//  Copyright © 2017 eay. All rights reserved.
//

import Foundation

class SignalChart : LineChartView, ChartViewDelegate
{
    @IBInspectable var signalName:String = ""
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        
        self.gridBackgroundColor = NSUIColor.white
        self.xAxis.drawGridLinesEnabled = false;
        self.xAxis.labelPosition = XAxis.LabelPosition.bottom
        //self.chartDescription?.text = "LineChartView Example"
        let chartData = LineChartData()
        let dataset = LineChartDataSet(values: [], label: signalName)
        
        dataset.drawCirclesEnabled = false
        dataset.colors = [NSUIColor.red]
        dataset.mode = .cubicBezier
        
        chartData.addDataSet(dataset)
        self.clear()
        self.data = chartData
    }
    
    func update(data: [ChartDataEntry])
    {
        let chartData = LineChartData()
        let dataset = LineChartDataSet(values: data, label: signalName)
        
        dataset.drawCirclesEnabled = false
        dataset.colors = [NSUIColor.red]
        dataset.mode = .cubicBezier
        
        chartData.addDataSet(dataset)
        self.clear()
        self.data = chartData
        
        self.notifyDataSetChanged()
    }
    
    func update1(data: ChartDataEntry, first: ChartDataEntry?)
    {
        //self.data.removeEntry(self.data?.dataSets.first.entri)
        if let fir = first
        {
            self.data?.removeEntry(fir, dataSetIndex: 0)
        }
        self.data?.addEntry(data, dataSetIndex: 0)
        self.notifyDataSetChanged()

    }
}
