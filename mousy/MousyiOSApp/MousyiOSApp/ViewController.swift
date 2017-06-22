//
//  ViewController.swift
//  MousyiOSApp
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
    @IBOutlet weak var sliderTrackingSpeed: UISlider!

    // MARK:- Storyboard Actions
    
    /**
     If not already started, this method starts reading inputs from sensors and calls the send method which will send the sensor data to driver via bluetooth, if already started it stops this proccess until it is called again.
     */
    @IBAction func startOrStopMouseMove(_ sender: Any)
    {
        if self.motionManager.isDeviceMotionActive
        {
            // Stop sending move info
            self.motionManager.stopDeviceMotionUpdates()
            buttonStartOrStopMouseMove.setTitle("Move Mouse", for: .normal)
        }
        else
        {
            buttonStartOrStopMouseMove.setTitle("Stop Mouse", for: .normal)
            // Srart sending data
            self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: readAndSendSensorData )
        }
        
    }
    /**
        Will tell the driver to do a left mouse click via bluetooth
     */
    @IBAction func leftClick(_ sender: Any)
    {
        self.mouseClick(action: Action.mouseLeftClick)
    }
    
    /**
        Will tell the driver to do a right mouse click via bluetooth
     */
    @IBAction func rightClick(_ sender: Any) {
        self.mouseClick(action: Action.mouseRightClick)
    }
    
    // MARK:- View Management
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.manager = CBCentralManager(delegate: self, queue: nil)
        self.motionManager = CMMotionManager()
    }
    
    // MARK:- Helpers
    
    /**
        Will tell the driver to do a mouse click via bluetooth. But first it stops sending sensor info to driver. This kinda prevents user from clicking wrong pleases. After it sends, it restarts the motion updates.
        - Parameters:
            - action: The type of action the needs to be send to the driver
     */
    func mouseClick(action: Action)
    {
        self.motionManager.stopDeviceMotionUpdates()
        self.send(action: action)
        self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: readAndSendSensorData  )
    }
    
    /**
     This is the method that is feed into startDeviceMotionUpdates as a parameter. It reads the rotation rate and the acceleration in 3 dimensions. Tries to little bit filtering and calls the method to send to driver via bluetooth.
     - Parameters:
        - motion: The instance of CMDeviceMotion which have the sensor datas
        - error: Contains the errors if any occured
     */
    func readAndSendSensorData(motion: CMDeviceMotion?, error: Error?)
    {
        if let dMotion = motion
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
            
            let xyz = XYZ(x: rr.x + acc.x, y: rr.y + acc.y, z: rr.z + acc.z, trackSpeed: Double(self.sliderTrackingSpeed.value))
            
            self.send(action: Action.mouseMove, message: "\(xyz)")
            
        }
        
    }
    
    // MARK:- Bluethooth Management
    
    /**
     Comforming to CBCentralManagerDelegate. This method scans for drivers.
     */
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        if central.state == CBManagerState.poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("Bluetooth not available.")
        }
    }
    
    /**
     Comforming to CBCentralManagerDelegate. This method is invoked with each found BLE device. It checks wheter this device is our driver, if it is it connects with it.
     */
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
    
    /**
     Comforming to CBCentralManagerDelegate. This method is invoked when devices are disconnect.
     */
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?)
    {
        labelAppStatus.text = "Disconnected"
    }
    
    
    /**
     Comforming to CBCentralManagerDelegate. This method is invoked when a connection occurs between this device and the driver, it looks for services in that driver. Unless some other BLE device is trying to mimic the driver or something is wrong, it should always be able to find services.
     */
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected")
        self.peripheral.discoverServices([SERVICE_UUID])
    }
    
    /**
     Comforming to CBPeripheralDelegate. This method will be invoked when services in the driver are discovered. it looks for characteristics in the discover service. Unless some other BLE device is trying to mimic the driver or something is wrong, it should always be able to find the characteristics.
     */
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
    
    /**
     Comforming to CBPeripheralDelegate. This method will be invoked when characteristics in the service are discovered. It enables the button on the screen. After this point we are ready send data to driver.
     */
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
    
    /**
     Comforming to CBPeripheralDelegate. This method will be invoked when something changes with the service. Right now we asume every change as service stopped.
     */
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        
        labelAppStatus.text = "Service stopeed"
        
        buttonLeftClick.isEnabled = false
        buttonRightClick.isEnabled = false
        buttonStartOrStopMouseMove.isEnabled = false
        
        self.manager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    /**
    This method sends and action and an optinal message to the driver
     - Parameters:
         - action: On of the cases of Action Enum.
         - message: Any additinional info to send, defaults to *nil*
     */
    func send(action: Action, message: String = "nil")
    {
        self.peripheral.writeValue(Package(action: action, value: message).toData(), for: self.charecteristic, type: CBCharacteristicWriteType.withoutResponse)
    }
}
