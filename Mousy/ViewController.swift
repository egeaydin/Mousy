//
//  ViewController.swift
//  MousY
//
//  Created by eay on 5/5/17.
//  Copyright © 2017 eay. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController
{    let manager = CMMotionManager()
    
    var sample: DataSample
    
    
    @IBOutlet weak var chartRawAcX: SignalChart!
    @IBOutlet weak var chartFilteredX: SignalChart!
    
    
    required init?(coder aDecoder: NSCoder) {
        sample = DataSample(size: Constants.sampleSize)
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if manager.isAccelerometerAvailable
        {
            manager.accelerometerUpdateInterval = 0.01
            manager.startAccelerometerUpdates(to: .main)
            {
                [weak self] (data: CMAccelerometerData?, error: Error?) in
                if let acceleration = data?.acceleration
                {
                    if let currentSeconds = self?.getCurrentSeconds()
                    {
                        if let sample = self?.sample
                        {
                            sample.add(value: acceleration.x, time:currentSeconds)
                            
                            self?.chartRawAcX.update(data: sample.data)
                            self?.chartFilteredX.update(data: sample.filteredData)
                            
                            //var linearAcceleration = sqrt(pow(x_acceleration, 2) + pow(y_acceleration, 2) + pow(z_acceleration, 2));
                        }
                    }
                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func getCurrentSeconds() -> Double
    {
        let date = Date()
        let calendar = Calendar.current
        let seconds = calendar.component(.second, from: date)
        let minutes = calendar.component(.minute, from: date)
        let hours = calendar.component(.hour, from: date)
        
        return Double(3600 * hours + 60 * minutes * seconds)
    }
}

