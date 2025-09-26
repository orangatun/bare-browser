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
    @State private var windowButtonHidden: Bool = true
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                // Background movable toggle with Cmd+P
                Button("") {
                    print("Movable pressed")
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
                Rectangle()
                    .fill((windowButtonHidden ? Color.clear : Color.orange.opacity(0.8)))
                    .clipShape(UnevenRoundedRectangle(
                        cornerRadii: RectangleCornerRadii(
                            topLeading: 0,
                            bottomLeading: 0,
                            bottomTrailing: 8,
                            topTrailing: 0
                        )
                    )).shadow(radius: 4)
                    .frame(width:80, height:32, alignment: .center)
                    .onHover { hovering in
                        print("Hovering \(hovering)")
                        windowButtonHidden.toggle()
                    }
                    .position(x:40, y: 16)
            }
            .ignoresSafeArea(.all, edges: .all)
            .background(WindowModifier(isMovable: $isMovable, windowButtonHidden: $windowButtonHidden))

        }
        .windowStyle(.hiddenTitleBar)
    }
}

struct WindowModifier : NSViewRepresentable {
    
    @Binding
    var isMovable: Bool
    @Binding
    var windowButtonHidden: Bool
    
    var view: NSView = NSView()
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        print("Update called Hidden: \(windowButtonHidden)\t Movable: \(isMovable)")
        DispatchQueue.main.async {
            if let window = NSApplication.shared.keyWindow {
                
                window.isMovableByWindowBackground = isMovable
                
                window.standardWindowButton(.closeButton)?.isHidden = windowButtonHidden
                window.standardWindowButton(.miniaturizeButton)?.isHidden = windowButtonHidden
                window.standardWindowButton(.zoomButton)?.isHidden = windowButtonHidden
            }
        }
    }
    func makeNSView(context: Context) -> some NSView {
        DispatchQueue.main.async {
            if let window = view.window {
                window.isMovableByWindowBackground = isMovable
                window.backgroundColor = NSColor.black.withAlphaComponent(0.7)
//                window.standardWindowButton(.closeButton)?.isHidden = true
//                window.standardWindowButton(.miniaturizeButton)?.isHidden = true
//                window.standardWindowButton(.zoomButton)?.isHidden = true
                window.styleMask.insert(.fullSizeContentView)
                window.standardWindowButton(.closeButton)?.isHidden = windowButtonHidden
                window.standardWindowButton(.miniaturizeButton)?.isHidden = windowButtonHidden
                window.standardWindowButton(.zoomButton)?.isHidden = windowButtonHidden
            }
        }
        return view
    }
}
