//
//  ContentView.swift
//  SwiftUIExample
//
//  Created by meitu@nenhall on 2022/12/2.
//

import SwiftUI

let obj = Obserer()

struct ContentView: View {
    
    @State var disabled: Bool = true
    @State var bodyText: String = "Type Feedback Here" {
        didSet {
            disabled = bodyText == "Type Feedback Here" || bodyText.isEmpty
        }
    }
    
    var body: some View {
        ZStack {
            textView
        }
        .frame(minWidth: 960, maxWidth: .infinity, minHeight: 540, maxHeight: .infinity)
    }
    
    var textView: some View {
        VStack {
            let bindingString = Binding<String>(get: {
                self.bodyText
            }, set: {
                self.bodyText = $0
            })
            if #available(macOS 14, *) {
                TextEditor(text: bindingString)
                    .textFieldStyle(.plain)
                    .font(.system(size: 12))
                    .background(Color.gray.opacity(0.5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(style: StrokeStyle(lineWidth: 0.5))
                    )
            } else {
                CocoaView {
                    let textView = NSTextView(frame: NSRect(x: 0, y: 0, width: 320, height: 104))
                    textView.string = bodyText
                    textView.textColor = .textColor
                    let scrollView = NSScrollView()
                    scrollView.documentView = textView
                    scrollView.autohidesScrollers = true
                    textView.delegate = obj
                    return scrollView
                } updater: { (nsView: NSScrollView) in
//                    print((nsView.documentView as? NSTextView)?.string)
                }
            }
        }
        
    }
    
    func onCommandSelector() {
        print("onCommand2")
    }
}

class Obserer: NSObject, NSTextViewDelegate {
    
    func textDidChange(_ notification: Notification) {
        print(#function, (notification.object as? NSTextView)?.string)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension NSTextView {
    
    open override var frame: CGRect {
        didSet {
//            backgroundColor = .clear //<<here clear
            drawsBackground = true
            isEditable = true
            isSelectable = true
        }
    }
    
    open override var acceptsFirstResponder: Bool {
        return true
    }
}

