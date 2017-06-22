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
        let w = 0.5
        if self.z < -w || self.z > w
        {
            pointer.x += CGFloat(self.trackSpeed) * CGFloat(-self.z)
            
            if pointer.x > screenWidth
            {
                pointer.x = screenWidth
            }
            else if(pointer.x < 0)
            {
                pointer.x = 0
            }
        }
        
        if self.x < -w || self.x > w
        {
            pointer.y += CGFloat(self.trackSpeed) * CGFloat(-self.x)
            
            if pointer.y > screenHeight
            {
                pointer.y = screenHeight
            }
            else if(pointer.y < 0)
            {
                pointer.y = 0
            }
        }
        
        return pointer
    }
}
