//
//  DataSample.swift
//  MousY
//
//  Created by eay on 5/6/17.
//  Copyright © 2017 eay. All rights reserved.
//  
//  Most of the work here is done by referencing below pdf.
//  All comments are directly coppied from the pdf incase the link gets broken
//  http://www.nxp.com/assets/documents/data/en/application-notes/AN3397.pdf

import Foundation
import Charts

class DataSample
{
    let size: Int
    private(set) var max:Double
    private(set) var data: [ChartDataEntry]
    private(set) var filteredData: [ChartDataEntry]
    
    let mechanicalFilterLimit: Double = 0.014
    
    init(size: Int)
    {
        self.size = size
        max = 0
        data = []
        filteredData = []
    }
    
    func add(value: Double, time: Double)
    {
        if(data.count == size)
        {
            //Sample is full, remove first element
            data.removeFirst()
        }
        data.append(ChartDataEntry(x:time, y:value))
        filteredData.append(ChartDataEntry(x:time, y:filter()))
        setMax(number: value)
    }
    
    /**
     Filter
     
     Low pass filtering of the signal is a very good way to remove noise (both mechanical and electrical) from the accelerometer.
     Reducing the noise is critical for a positioning application in order to reduce major errors when integrating the signal.
     A simple way for low pass filtering a sampled signal is to perform a rolling average. Filtering is simply then reduced to obtain
     the average of a set of samples. It is important to obtain the average of a balanced amount of samples. Taking too many samples
     to do this process can result in a loss of data, yet taking too few can result in an inaccurate value.
     
     - Complexity: O(n)
     */
    private func filter() -> Double
    {
        var filteredData: Double = 0
        for d in data
        {
            filteredData += d.y
        }
        
        //The resulting average represents the acceleration of an instant.
        return validateData(filteredData / Double(data.count))
    }
    
    /**
     Mechanical Filtering Window:
     
     When a no movement condition is present, minor errors in acceleration could be interpreted as a constant velocity due to the
     fact that samples not equal to zero are being summed; the ideal case for a no movement condition is all the samples to be zero.
     That constant velocity indicates a continuous movement condition and therefore an unstable position.
     Even with the previous filtering some data can be erroneous, so a ìwindowî of discrimination between ìvalid dataî and ìinvalid
     dataî for the no movement condition must be implemented.
     
     - Complexity: O(1)
     */
    private func validateData(_ data: Double) -> Double
    {
        if(-mechanicalFilterLimit <= data && data <= mechanicalFilterLimit)
        {
            return 0
        }
        return data
        
    }
    
    /**
     Determines the maximum value of the sample
     
     - Complexity: O(1)
     */
    private func setMax(number: Double)
    {
        if(number > max)
        {
            max = number
        }
    }

}
