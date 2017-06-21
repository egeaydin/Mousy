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
    let x: Double
    let y: Double
    let z: Double
    
    public var description: String { return "x:\(self.x),y:\(self.y),z:\(self.z)" }
    
    init(x: Double, y: Double, z: Double)
    {
        self.x = x
        self.y = y
        self.z = z
    }
    
    static func from(string: String) throws -> XYZ
    {
        let values = string.components(separatedBy: ",")
        
        var x = 0.0
        var y = 0.0
        var z = 0.0
        
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
            default:
                throw ConversionError.InvalidInputString("The input string has an invalid character: \(p[0])")
            }
        }
        
        return XYZ(x:x, y:y, z:z)
    }
}

enum ConversionError : Error {
    case InvalidInputString(String)
}
