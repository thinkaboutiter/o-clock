//
//  ClockView.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI
import Combine
import UIKit

struct ClockView: View {
    @State private var currentTime = Date()
    @State private var showSettings = false
    @State private var selectedFont: ClockFont = .system
    @State private var clockFontSize: CGFloat = 180
    @State private var dateFontSize: CGFloat = 40
    @State private var showDate: Bool = true
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
                    fontSize: clockFontSize,
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

            if showDate {
                VStack {
                    Spacer()
                    Text(formatDate(currentTime))
                        .font(selectedFont.getFont(size: dateFontSize).weight(.regular))
                        .foregroundColor(fontColor)
                        .padding(.bottom, 50)
                }
            }
        }
        .onReceive(timer) { _ in
            currentTime = Date()
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(
                selectedFont: $selectedFont,
                clockFontSize: $clockFontSize,
                dateFontSize: $dateFontSize,
                showDate: $showDate,
                backgroundColor: $backgroundColor,
                fontColor: $fontColor
            )
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMMM dd"
        return formatter.string(from: date)
    }
}

#Preview {
    ClockView()
}
