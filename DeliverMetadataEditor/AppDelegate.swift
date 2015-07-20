//
//  AppDelegate.swift
//  DeliverMetadataEditor
//
//  Created by Francis Chong on 20/7/15.
//  Copyright © 2015 Ignition Soft. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if let firstWindow = sender.windows.first {
            firstWindow.makeKeyAndOrderFront(sender)
        }
        return true
    }
}

