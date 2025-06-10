//
//  ClockView.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI

struct ClockView: View {
    @State private var currentTime = Date()
    @State private var showSettings = false
    @State private var selectedFont: ClockFont = .system
    @State private var fontSize: CGFloat = 80
    @State private var backgroundColor: Color = .black
    @State private var fontColor: Color = .white
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            ClockDisplayView(
                currentTime: currentTime,
                selectedFont: selectedFont,
                fontSize: fontSize,
                fontColor: fontColor,
                onSettingsPressed: {
                    showSettings.toggle()
                }
            )
        }
        .onReceive(timer) { _ in
            currentTime = Date()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(
                selectedFont: $selectedFont,
                fontSize: $fontSize,
                backgroundColor: $backgroundColor,
                fontColor: $fontColor
            )
        }
    }
}

#Preview {
    ClockView()
}
