//
//  AppDelegate.swift
//  macOSExample
//
//  Created by nenhall on 2022/10/21.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var window: NSWindow = {
        let window = NSWindow()
        window.styleMask = [.closable, .miniaturizable, .titled, .resizable, .fullSizeContentView]
        window.backingType = .buffered
        window.titlebarAppearsTransparent = true
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: ContentView())
        window.autorecalculatesKeyViewLoop = true
        return window
    }()
    lazy var windowController = NSWindowController(window: window)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        windowController.showWindow(self)
        window.center()
    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

}

