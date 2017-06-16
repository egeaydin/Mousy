//
//  Extensions.swift
//  Mousy
//
//  Created by Ege Aydin on 6/3/17.
//  Copyright © 2017 Ege Aydin. All rights reserved.
//

import Foundation

extension Array {
    
    func beforeLast() -> Element
    {
        return self[self.count - 2]
    }
}
