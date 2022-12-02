//
//  ViewController.swift
//  macOSExample
//
//  Created by nenhall on 2022/10/21.
//

import Cocoa

class ViewController: NSViewController {
    var sessionCode: NSApplication.ModalSession?

    let queue = DispatchQueue(label: "xxxx", qos: .background)
    let queue2 = DispatchQueue(label: "xxxx2")
    let semaphore = DispatchSemaphore(value: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: NSWindow.willCloseNotification, object: nil, queue: .main) { [weak self] note in
            guard let self = self else { return }
            guard NSApp.modalWindow != nil else { return }
            if let sessionCode = self.sessionCode {
                NSApp.endModalSession(sessionCode)
                self.sessionCode = nil
            } else {
                NSApp.stopModal()
            }
        }
    }

    @IBAction func showWindow(_ sender: Any?) {
        let nextWindow = NextWindow(
            contentRect: NSRect(x: 0, y: 0, width: 540, height: 360),
            styleMask: [.closable, .miniaturizable, .resizable, .titled, .fullSizeContentView],
            backing: .buffered,
            defer: true
        )
        nextWindow.titleVisibility = .hidden
        nextWindow.setContentBorderThickness(22, for: .minY)
        nextWindow.setAutorecalculatesContentBorderThickness(false, for: .minY)
        nextWindow.center()
        
        let windowController = NSWindowController(window: nextWindow)
        windowController.showWindow(nil)
    }

    @IBAction func modalWindow(_ sender: Any?) {
        guard let nextWindow = createNewWindow() else { return }
        NSApp.runModal(for: nextWindow)
    }

    @IBAction func modalSessionsWindow(_ sender: Any?) {
        guard let nextWindow = createNewWindow() else { return }
       sessionCode = NSApp.beginModalSession(for: nextWindow)
    }

    override func mouseDown(with event: NSEvent) {
        let view2 = BasicView(frame: NSRect(x: 0, y: 0, width: 500, height: 500))
        view2.layer = CALayer()
        view2.wantsLayer = true
        let btn = NSButton(title: "Layer-Hosting View", target: nil, action: nil)
        btn.frame = NSRect(x: 0, y: 50, width: 200, height: 35)
        view2.addSubview(btn)
        view.addSubview(view2)
    }
}

extension ViewController {

    func createNewWindow() -> NSWindow? {
        let windowController = NextWindowController(windowNibName: NSNib.Name("NextWindowController"))
        return windowController.window
    }
}
