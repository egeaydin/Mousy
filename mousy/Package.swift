//
//  Package.swift
//  
//
//  Created by Ege Aydin on 6/21/17.
//
//

import Foundation

class Package
{
    let action: Action
    let value: String
    
    init(action: Action, value: String)
    {
        self.action = action
        self.value = value
    }
    
    func toData() -> Data
    {
        return "\(action.rawValue)|\(value)".data(using: String.Encoding.utf8)!
    }
    
    static func from(data: Data) -> Package
    {
        let str = String(data: data, encoding: String.Encoding.utf8)!
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
