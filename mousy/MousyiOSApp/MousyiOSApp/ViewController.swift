//
//  ViewController.swift
//  MousyMacApp
//
//  Created by Ege Aydin on 6/13/17.
//  Copyright © 2017 Ege Aydin. All rights reserved.
//

import CoreBluetooth
import CoreMotion
import Foundation
import UIKit

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate, UIGestureRecognizerDelegate
{
    // MARK:- Instance Properties
    var manager:CBCentralManager!
    var peripheral:CBPeripheral!
    var charecteristic: CBCharacteristic!
    var motionManager: CMMotionManager!
    var counter = 0
    
    // MARK:- Storyboard Outlets
    
    @IBOutlet weak var labelAppStatus: UILabel!
    @IBOutlet weak var buttonLeftClick: UIButton!
    @IBOutlet weak var buttonRightClick: UIButton!
    @IBOutlet weak var buttonStartOrStopMouseMove: UIButton!

    // MARK:- Storyboard Actions
    
    @IBAction func startOrStopMouseMove(_ sender: Any) {
        if self.motionManager.isDeviceMotionActive
        {
            // Stop sending move info
            self.motionManager.stopDeviceMotionUpdates()
            buttonStartOrStopMouseMove.titleLabel!.text = "Move Mouse"
        }
        else
        {
            // Srart sending data
            self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler:
                {
                    deviceMotion, error in
                    if let dMotion = deviceMotion
                    {
                        let rr = dMotion.rotationRate
                        let acc = dMotion.userAcceleration
                        
                        //let rotModel = XYZ(x: rr.x, y: rr.y, z: rr.z)
                        //let accModel = XYZ(x: acc.x, y: acc.y, z: acc.z)
                        
                        var x = rr.x
                        var y = rr.y
                        var z = rr.z
                        
                        let minAcc = 0.2
                        
                        if(acc.x > minAcc)
                        {
                            x += acc.x
                        }
                        if(acc.y > minAcc)
                        {
                            y += acc.y
                        }
                        if(acc.z > minAcc)
                        {
                            z += acc.z
                        }
                        
                        let xyz = XYZ(x: rr.x + acc.x, y: rr.y + acc.y, z: rr.z + acc.z)
                        
                        self.peripheral.writeValue(Package(key: Action.mouseMove, value: "\(xyz)").toData(), for: self.charecteristic, type: CBCharacteristicWriteType.withoutResponse)
                        
                    }
            })
            buttonStartOrStopMouseMove.titleLabel!.text = "Stop Mouse"
        }
        
    }
    
    @IBAction func leftClick(_ sender: Any) {
        self.peripheral.writeValue(Package(key: Action.mouseLeftClick, value: "nil").toData(), for: self.charecteristic, type: CBCharacteristicWriteType.withoutResponse)
    }
    @IBAction func rightClick(_ sender: Any) {
        self.peripheral.writeValue(Package(key: Action.mouseRightClick, value: "nil").toData(), for: self.charecteristic, type: CBCharacteristicWriteType.withoutResponse)
    }

    // MARK:- View Management
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.manager = CBCentralManager(delegate: self, queue: nil)
        self.motionManager = CMMotionManager()
    }
    
    
    // MARK:- Bluethooth Management
    
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        if central.state == CBManagerState.poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("Bluetooth not available.")
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber)
    {
        if let localName = advertisementData[CBAdvertisementDataLocalNameKey]
        {
            if String(describing: localName) == "mousyMacApp"
            {
                self.manager.stopScan()
                
                self.peripheral = peripheral
                self.peripheral.delegate = self
                manager.connect(peripheral, options: nil)
                
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?)
    {
        labelAppStatus.text = "Disconnected"
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected")
        self.peripheral.discoverServices([SERVICE_UUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?)
    {
        if let err = error
        {
            print("Error: \(err)")
        }
        
        for service in peripheral.services! {
            let thisService = service as CBService
            print("Service discovered")
            peripheral.discoverCharacteristics([CHARACTER_UUID], for: thisService)
            break
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?)
    {
        for characteristic in service.characteristics! {
            let thisCharacteristic = characteristic as CBCharacteristic
            print("Charecterisric is discovered")
            charecteristic = thisCharacteristic
            labelAppStatus.text = "App found"
            
            buttonLeftClick.isEnabled = true
            buttonRightClick.isEnabled = true
            buttonStartOrStopMouseMove.isEnabled = true
            
            self.peripheral.setNotifyValue(true, for: thisCharacteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("wrote value")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        
        labelAppStatus.text = "Service stopeed"
        
        buttonLeftClick.isEnabled = false
        buttonRightClick.isEnabled = false
        buttonStartOrStopMouseMove.isEnabled = false
        
        self.manager.scanForPeripherals(withServices: nil, options: nil)
    }
}
