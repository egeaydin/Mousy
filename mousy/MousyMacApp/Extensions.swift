//
//  XYZExtension.swift
//  MousyMacApp
//
//  Created by Ege Aydin on 6/21/17.
//  Copyright © 2017 Ege Aydin. All rights reserved.
//

import Foundation

extension XYZ
{
    func getAsMousePoint(pointer: inout CGPoint) -> CGPoint
    {
        pointer.x = self.checkBounds(newCoordinate: CGFloat(self.z), currentCoordinate: pointer.x, maxBound: screenWidth)
        pointer.y = self.checkBounds(newCoordinate: CGFloat(self.x), currentCoordinate: pointer.y, maxBound: screenHeight)
        
        return pointer
    }
    
    private func checkBounds(newCoordinate: CGFloat, currentCoordinate: CGFloat, maxBound: CGFloat) -> CGFloat
    {
        let w = 0.2
        var rtn = currentCoordinate
        
        if self.x < -w || self.x > w
        {
            rtn += CGFloat(self.trackSpeed) * CGFloat(-newCoordinate)
            
            if rtn > maxBound
            {
                rtn = maxBound
            }
            else if(rtn < 0)
            {
                rtn = 0
            }
        }
        
        return rtn

    }
}
