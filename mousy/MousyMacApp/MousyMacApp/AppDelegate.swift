//
//  AppDelegate.swift
//  MousyMacApp
//
//  Created by Ege Aydin on 6/17/17.
//  Copyright © 2017 Ege Aydin. All rights reserved.
//


import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        let scrn: NSScreen = NSScreen.main()!
        let rect: NSRect = scrn.frame
        screenHeight =  rect.size.height
        screenWidth = rect.size.width
    }
}
