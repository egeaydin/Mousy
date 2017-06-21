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
import CoreGraphics


class GameScene: SKScene, CBPeripheralManagerDelegate
{
    var peripheralManager: CBPeripheralManager!
    var characteristics: CBCharacteristic!
    var pointer: SKSpriteNode!
    
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    
    required init?(coder: NSCoder)
    {
        let scrn: NSScreen = NSScreen.main()!
        let rect: NSRect = scrn.frame
        screenHeight =  rect.size.height
        screenWidth = rect.size.width
        
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
    
    override func didMove(to view: SKView) {
        pointer = self.childNode(withName: "pointer") as! SKSpriteNode
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
            let acc = try XYZ.fromData(data: requests.first!.value!)
            print(acc)
            // pointer.physicsBody!.applyForce(CGVector(dx: 100 * CGFloat(-acc.z), dy: 100 * CGFloat(acc.x)))
            let w = 0.5
            if acc.z < w || acc.z > w
            {
                pointer.position.x += 15 * CGFloat(-acc.z)
                
                if pointer.position.x > screenWidth
                {
                    pointer.position.x = screenWidth
                }
                else if(pointer.position.x < 0)
                {
                    pointer.position.x = 0
                }
            }
            
            if acc.x < w || acc.x > w
            {
                pointer.position.y += 15 * CGFloat(-acc.x)
                
                if pointer.position.y > screenHeight
                {
                    pointer.position.y = screenHeight
                }
                else if(pointer.position.y < 0)
                {
                    pointer.position.y = 0
                }
            }
            
            CGWarpMouseCursorPosition(CGPoint(x: pointer.position.x, y: pointer.position.y))
        }
        catch
        {
            print("error")
        }
    }
    
}
