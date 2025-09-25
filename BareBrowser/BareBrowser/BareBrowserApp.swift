//
//  BareBrowserApp.swift
//  BareBrowser
//
//  Created by orangatun on 9/22/25.
//

import SwiftUI

@main
struct BareBrowserApp: App {
    
    @State private var isMovable: Bool = false
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                // Background movable toggle with Cmd+P
                Button("") {
                    isMovable.toggle()
                }
                .hidden()
                .keyboardShortcut("p")
                
                // Appliction terminate with Cmd+Q
                Button("") {
                    NSApplication.shared.terminate(nil)
                }
                .hidden()
                .keyboardShortcut("w")
               
            }
            .ignoresSafeArea(.all, edges: .all)
            .background(WindowModifier(isMovable: $isMovable))
        }
        .windowStyle(.hiddenTitleBar)
    }
}

struct WindowModifier : NSViewRepresentable {
    var view: NSView = NSView()
    func updateNSView(_ nsView: NSViewType, context: Context) {
        DispatchQueue.main.async {
            if let window = view.window {
                window.isMovableByWindowBackground = isMovable
            }
        }
    }
    @Binding var isMovable: Bool
    func makeNSView(context: Context) -> some NSView {
        DispatchQueue.main.async {
            if let window = view.window {
                window.titleVisibility = .hidden
                window.titlebarAppearsTransparent = true
                window.isMovableByWindowBackground = true
                window.isMovableByWindowBackground = isMovable
                window.backgroundColor = NSColor.black.withAlphaComponent(0.7)
//                window.standardWindowButton(.closeButton)?.isHidden = true
//                window.standardWindowButton(.miniaturizeButton)?.isHidden = true
//                window.standardWindowButton(.zoomButton)?.isHidden = true
                window.styleMask.insert(.fullSizeContentView)
            }
        }
        return view
    }
}
