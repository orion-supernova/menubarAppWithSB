//
//  AppDelegate.swift
//  menubarAppWithSB
//
//  Created by Murat Can KOÇ on 28.01.2022.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = "👽"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(showSettings)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @objc func showSettings() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateController(withIdentifier: "ViewController") as? ViewController else {
            fatalError("Unable to find the ViewController in the storyboard")
        }

        guard let button = statusItem.button else {
            fatalError("Unable to fin the status item button")
        }

        let popOverView = NSPopover()
        popOverView.contentViewController = viewController
        popOverView.behavior = .transient
        popOverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)
    }
}

