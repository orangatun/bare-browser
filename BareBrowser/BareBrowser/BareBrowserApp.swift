//
//  BareBrowserApp.swift
//  BareBrowser
//
//  Created by orangatun on 9/22/25.
//

import SwiftUI

@main
struct BareBrowserApp: App {
    var body: some Scene {
        WindowGroup {
            .background(WindowModifier())
            ZStack {
                ContentView()
            }
        }
        .windowStyle(.hiddenTitleBar)
    }
}

struct WindowModifier : NSViewRepresentable {
    func updateNSView(_ nsView: NSViewType, context: Context) {}
    
    func makeNSView(context: Context) -> some NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let window = view.window {
                window.titleVisibility = .hidden
                window.titlebarAppearsTransparent = true
                window.isMovableByWindowBackground = true
                window.backgroundColor = NSColor.black.withAlphaComponent(0.7)
//                window.standardWindowButton(.closeButton)?.isHidden = true
//                window.standardWindowButton(.miniaturizeButton)?.isHidden = true
//                window.standardWindowButton(.zoomButton)?.isHidden = true
            }
        }
        return view
    }
}
