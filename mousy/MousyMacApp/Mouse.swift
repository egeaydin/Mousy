//
//  MouseAction.swift
//  MousyMacApp
//
//  Created by Ege Aydin on 6/21/17.
//  Copyright © 2017 Ege Aydin. All rights reserved.
//

import Foundation

class Mouse
{
    class func operate(package: Package, point: inout CGPoint) throws
    {
        switch package.action
        {
        case Action.mouseMove:
            let xyz = try XYZ.from(string: package.value)
            print("\(package.action), \(xyz)")
            point = xyz.getAsMousePoint(pointer: &point)
            CGWarpMouseCursorPosition(CGPoint(x: point.x, y: point.y))
    
       // https://stackoverflow.com/questions/2734117/simulating-mouse-input-programmatically-in-os-x/41196453#41196453
        case Action.mouseLeftClick:
            print("left click")
            guard let downEvent = CGEvent(mouseEventSource: nil, mouseType: .leftMouseDown, mouseCursorPosition: point, mouseButton: .left) else {
                return
            }
            guard let upEvent = CGEvent(mouseEventSource: nil, mouseType: .leftMouseUp, mouseCursorPosition: point, mouseButton: .left) else {
                return
            }
            downEvent.post(tap: CGEventTapLocation.cghidEventTap)
            upEvent.post(tap: CGEventTapLocation.cghidEventTap)
            
        case Action.mouseRightClick:
            print("right click")
        }
    }
    
    
}
