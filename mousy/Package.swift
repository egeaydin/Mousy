///
///  Package.swift
///
///
///  Created by Ege Aydin on 6/21/17.
///
///  This class is shared by both Mac and iOS App, this type is used for sending information from iOS device to       Mac Device(driver)

import Foundation

class Package
{
    let action: Action
    let value: String
    
    /**
     Initializases a new package instance
     - Parameters:
         - action: One of the cases of Action Enum.
         - value: Any additinional info to send, defaults to *nil*
     */
    init(action: Action, value: String)
    {
        self.action = action
        self.value = value
    }
    
    /**
     Coverts a Package instance to Data instance. Which the actual object type that can be send via bluetooth. It first converts the action and value to string, by joining them with a |, then converts it to data with utf8 encoding

     - Returns: The transfarable data instance.      
    */
    func toData() -> Data
    {
        return "\(action.rawValue)|\(value)".data(using: String.Encoding.utf8)!
    }
    
    /**
     Creates a new Package instance from Data instance.
     TODO: There is no garantee that this method will be succesfull al the time, validate the data
        - Returns: The transfarable data instance
     */
    static func from(data: Data) -> Package
    {
        let str = String(data: data, encoding: String.Encoding.utf8)!
        // If the string is from the iOSApp it keys should be seperated by |, so we split by it.
        let p = str.components(separatedBy: "|")
        return Package(action: Action(rawValue: p[0])!, value: p[1])
    }
}

enum Action : String
{
    case mouseMove = "mousemMove"
    case mouseLeftClick = "mouseLeftClick"
    case mouseRightClick = "mouseRightClick"
}
