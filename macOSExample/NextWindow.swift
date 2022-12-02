//
//  NextWindow.swift
//  macOSExample
//
//  Created by nenhall on 2022/10/21.
//

import Cocoa

class NextWindow: NSWindow {

    override init(contentRect: NSRect,
                  styleMask style: NSWindow.StyleMask,
                  backing type: NSWindow.BackingStoreType,
                  defer flag: Bool) {
        super.init(contentRect: contentRect,
                   styleMask: style,
                   backing: type,
                   defer: flag)
        print(#function)
        setUpSubviews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
    }

    private func setUpSubviews() {
        title = "纯代码创建的 Window"

        guard let contentView = contentView else { return }
        let button = NSButton(title: "纯代码创建的 Window", target: nil, action: nil)

        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    override func mouseDown(with event: NSEvent) {
        if contentBorderThickness(for: .minY) == 0 {
            setContentBorderThickness(22, for: .minY)
        } else {
            setContentBorderThickness(0, for: .minY)
        }
    }

    override func makeKey() {
        super.makeKey()
        print(#function)
    }

    override func makeKeyAndOrderFront(_ sender: Any?) {
        super.makeKeyAndOrderFront(sender)
        print(#function)
    }

    override func orderFront(_ sender: Any?) {
        super.orderFront(sender)
        print(#function)
    }

    override func orderOut(_ sender: Any?) {
        super.orderOut(sender)
        print(#function)
    }

    deinit {
        print(#function)
    }
}
