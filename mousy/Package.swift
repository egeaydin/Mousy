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
    private let _package: String
    init(key: Action, value: String)
    {
        _package = "\(key.rawValue)|\(value)"
    }
    
    func toData() -> Data
    {
        return _package.data(using: String.Encoding.utf8)!
    }
    
    static func from(data: Data) -> (key:Action, value:String)
    {
        let str = String(data: data, encoding: String.Encoding.utf8)!
        let p = str.components(separatedBy: "|")
        return (Action(rawValue: p[0])!, p[1])
    }
}

enum Action : String
{
    case mouseMove = "mousemMove"
    case mouseLeftClick = "mouseLeftClick"
    case mouseRightClick = "mouseRightClick"
}
