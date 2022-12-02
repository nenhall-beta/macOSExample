//
//  BasicView.swift
//  macOSExample
//
//  Created by nenhall on 2022/10/21.
//

import Cocoa

class BasicView: NSView {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        layer = CALayer()
        wantsLayer = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        // canDrawSubviewsIntoLayer = true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSColor.darkGray.setFill()
//        dirtyRect.fill()
//        layerContentsRedrawPolicy = .onSetNeedsDisplay
        print(#function)
    }

//    override var wantsUpdateLayer: Bool {
//        return true
//    }

    override var acceptsFirstResponder: Bool {
        true
    }
}

