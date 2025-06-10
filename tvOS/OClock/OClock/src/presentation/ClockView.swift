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
    @State private var fontSize: CGFloat = 100
    @State private var backgroundColor: Color = .black
    @State private var fontColor: Color = .white
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                ClockDisplayView(
                    currentTime: currentTime,
                    selectedFont: selectedFont,
                    fontSize: fontSize,
                    fontColor: fontColor
                )
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Button("⚙") {
                        showSettings.toggle()
                    }
                    .font(.title2)
                    .foregroundColor(fontColor.opacity(0.3))
                    .padding(.bottom, 50)
                }
            }
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
