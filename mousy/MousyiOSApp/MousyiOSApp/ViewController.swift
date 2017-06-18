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

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate
{
    var manager:CBCentralManager!
    var peripheral:CBPeripheral!
    var charecteristic: CBCharacteristic!
    var motionManager: CMMotionManager!
    
    
    let SERVICE_UUID = CBUUID(string: "a495ff20-c5b1-4b44-b512-1370f02d74de")
    let CHARACTER_UUID = CBUUID(string: "c4ac425e-ab73-46ff-aff8-e89d32df6d12")
    
    
    
    var counter = 0
    
    @IBOutlet weak var labelAppStatus: UILabel!
    
    @IBOutlet weak var buttonStart: UIButton!
    
    @IBAction func startSending(_ sender: Any) {
        self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: {  deviceMotion, error in
            if let dMotion = deviceMotion
            {
                let rr = dMotion.rotationRate
                
                let rotModel = XYZ(x: rr.x, y: rr.y, z: rr.z)
                
                self.peripheral.writeValue(rotModel.toData(), for: self.charecteristic, type: CBCharacteristicWriteType.withoutResponse)
                
            }
        })
        
        
    }
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.manager = CBCentralManager(delegate: self, queue: nil)
        self.motionManager = CMMotionManager()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
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
            buttonStart.isEnabled = true
            self.peripheral.setNotifyValue(true, for: thisCharacteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("wrote value")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        
        labelAppStatus.text = "Service stopeed"
        buttonStart.isEnabled = false
        self.manager.scanForPeripherals(withServices: nil, options: nil)
    }
}
