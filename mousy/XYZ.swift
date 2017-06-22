//
//  RotationModel.swift
//  
//
//  Created by Ege Aydin on 6/15/17.
//
//

import Foundation

class XYZ: CustomStringConvertible
{
    var x: Double
    var y: Double
    var z: Double
    
    var trackSpeed: Double
    
    public var description: String { return "x:\(self.x),y:\(self.y),z:\(self.z),t:\(self.trackSpeed)" }
    
    init(x: Double, y: Double, z: Double, trackSpeed: Double)
    {
        self.x = x
        self.y = y
        self.z = z
        self.trackSpeed = trackSpeed
    }
    
    static func from(string: String) throws -> XYZ
    {
        let values = string.components(separatedBy: ",")
        
        var x = 0.0
        var y = 0.0
        var z = 0.0
        var trackSpeed = 0.0
        
        for pair in values
        {
            let p = pair.components(separatedBy: ":")
            let value = Double(p[1])!
            switch p[0]
            {
            case "x":
                x = value
            case "y":
                y = value
            case "z":
                z = value
            case "t":
                trackSpeed = value
            default:
                throw ConversionError.InvalidInputString("The input string has an invalid character: \(p[0])")
            }
        }
        
        return XYZ(x:x, y:y, z:z, trackSpeed: trackSpeed)
    }
}

enum ConversionError : Error {
    case InvalidInputString(String)
}
