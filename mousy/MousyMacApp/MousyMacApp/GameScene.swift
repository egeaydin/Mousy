//
//  GameScene.swift
//  MousyMacApp
//
//  Created by Ege Aydin on 6/17/17.
//  Copyright © 2017 Ege Aydin. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreBluetooth

class GameScene: SKScene, CBPeripheralManagerDelegate
{
    var peripheralManager: CBPeripheralManager!
    var characteristics: CBCharacteristic!
    
    let SERVICE_UUID = CBUUID(string: "a495ff20-c5b1-4b44-b512-1370f02d74de")
    let CHARACTER_UUID = CBUUID(string: "c4ac425e-ab73-46ff-aff8-e89d32df6d12")
    //pok
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        characteristics = CBMutableCharacteristic(type: CHARACTER_UUID, properties: CBCharacteristicProperties.writeWithoutResponse, value: nil, permissions: CBAttributePermissions.writeable)
        let service = CBMutableService(type: SERVICE_UUID, primary: true)
        service.characteristics = [characteristics]
        
        peripheralManager.add(service)
        
        var advDict = [String:Any]()
        advDict[CBAdvertisementDataLocalNameKey] = "mousyMacApp"
        
        peripheralManager.startAdvertising(advDict)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager)
    {
        print(peripheral.state)
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?)
    {
        if let err = error
        {
            print("Error: \(err)")
        }
        else
        {
            print("Service has been started")
        }
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?)
    {
        if let err = error
        {
            print("Error: \(err)")
        }
        else
        {
            print("Advertising has been started")
        }
    }
    
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        do
        {
            let rotation = try XYZ.fromData(data: requests.first!.value!)
            print(rotation)
        }
        catch
        {
            print("error")
        }
    }
    
}
