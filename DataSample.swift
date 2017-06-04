//
//  DataSample.swift
//  MousY
//
//  Created by eay on 5/6/17.
//  Copyright © 2017 eay. All rights reserved.
//  
//  Most of the work here is done by referencing below pdf.
//  Most of the comments are directly coppied from the pdf incase the link gets broken
//  http://www.nxp.com/assets/documents/data/en/application-notes/AN3397.pdf

import Foundation
import Charts

class DataSample
{
    let size: Int
    private(set) var max:Double
    private(set) var data: [ChartDataEntry]
    private(set) var filteredData: [ChartDataEntry]
    private(set) var velocityData: [ChartDataEntry]
    private(set) var positionData: [ChartDataEntry]
    
    let mechanicalFilterLimit: Double = 0.014
    
    // MARK: -
    
    init(size: Int)
    {
        self.size = size
        max = 0
        data = []
        filteredData = []
        velocityData = []
        positionData = []
        
        //We need to add the first two elements of velocityData and positionData, the initial value is zero
        let time = getCurrentSeconds()
        velocityData.append(ChartDataEntry(x: time, y: 0))
        velocityData.append(ChartDataEntry(x: time, y: 0))
        positionData.append(ChartDataEntry(x: time, y: 0))
        positionData.append(ChartDataEntry(x: time, y: 0))
    }
    
    /**
     Adds a new value to the samples. Then filters it and tries to calculates position.
     
     - Complexity: O(n)
     */

    func add(value: Double)
    {
        if(data.count == size)
        {
            //Sample is full, remove first elements
            data.removeFirst()
            filteredData.removeFirst()
        }
        
        //We read the time here in order to make sure that all data arrays have the same time
        let time = getCurrentSeconds()
        
        data.append(ChartDataEntry(x:time, y:value))
        filteredData.append(ChartDataEntry(x:time, y:filter()))
        calculatePosition(time:time)
        setMax(number: value)
    }
    
    /**
     Filter
     
     Low pass filtering of the signal is a very good way to remove noise (both mechanical and electrical) from the accelerometer. Reducing the noise is critical for a positioning application in order to reduce major errors when integrating the signal. A simple way for low pass filtering a sampled signal is to perform a rolling average. Filtering is simply then reduced to obtain the average of a set of samples. It is important to obtain the average of a balanced amount of samples. Taking too many samples to do this process can result in a loss of data, yet taking too few can result in an inaccurate value.
     
     - Complexity: O(n)
     */
    private func filter() -> Double
    {
        // We are taking moving avarage here
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
     
     When a no movement condition is present, minor errors in acceleration could be interpreted as a constant velocity due to the fact that samples not equal to zero are being summed; the ideal case for a no movement condition is all the samples to be zero. That constant velocity indicates a continuous movement condition and therefore an unstable position. Even with the previous filtering some data can be erroneous, so a ìwindowî of discrimination between ìvalid dataî and ìinvalid dataî for the no movement condition must be implemented.
     
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
     Determines the maximum value of the sample by testing the input wih the current value.
     - Parameters:
        - number: The number being tested against the current maximum value
     - Complexity: O(1)
     */
    func setMax(number: Double)
    {
        if(number > max)
        {
            max = number
        }
    }
    /**
     This function transforms acceleration to a proportional position by integrating the acceleration data twice. It also adjusts sensibility by multiplying position. This integration algorithm carries error, which is compensated with "didMovementEnd" subroutine. Faster sampling frequency implies less error but requires more memory.
        TODO: Add sensibility and try to complete the algorithm.
     - Complexity: O(1)
     */
    private func calculatePosition(time: Double)
    {
        // To make sure that we have at least two data
        if filteredData.count > 1
        {
            // Taking first integration in order to calculate velocity
            let velocity = velocityData.beforeLast().y + (filteredData.last?.y)! + ((filteredData.last?.y)! - filteredData.beforeLast().y)
            
            velocityData.append(ChartDataEntry(x: time, y:velocity))
            
            // Taking second integration in order to calculate position
            let position = positionData.beforeLast().y + (velocityData.last?.y)! + ((velocityData.last?.y)! - velocityData.beforeLast().y)
            
            positionData.append(ChartDataEntry(x: time, y: position))
        }
    }
    
    /**
     This function gets the current time and converts it into total seconds. The reason for that is so the X-axis of the graph will have uniqe values
     - Returns: A unique number that represents time for the chart.
     - Complexity: O(1)
    */
    private func getCurrentSeconds() -> Double
    {
        let date = Date()
        let calendar = Calendar.current
        let seconds = calendar.component(.second, from: date)
        let minutes = calendar.component(.minute, from: date)
        let hours = calendar.component(.hour, from: date)
        
        return Double(3600 * hours + 60 * minutes * seconds)
    }
    
    /**
     This function allows movement end detection. If a certain number of acceleration samples are equal to zero we can assume movement has stopped. Accumulated Error generated in the velocity calculations is eliminated by resetting the velocity variables. This stops position increment and greatly eliminates position error.
     
     - Complexity: O(1)
     */
    private func didMovementEnd() -> Bool
    {
        var zeroCount = 0
        for data in filteredData
        {
            if data.y == 0
            {
                zeroCount += 1
            }
            if zeroCount > 24
            {
                return true
            }
        }
        return false
    }

}
