//
//  ClockDisplayView.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI

struct ClockDisplayView: View {
    let currentTime: Date
    let selectedFont: ClockFont
    let fontSize: CGFloat
    let fontColor: Color
    let onSettingsPressed: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            Text(timeString)
                .font(selectedFont.getFont(size: fontSize).weight(.medium))
                .foregroundColor(fontColor)
                .monospacedDigit()
            
            Button("Settings") {
                onSettingsPressed()
            }
            .foregroundColor(fontColor.opacity(0.7))
        }
    }
    
    private var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        return formatter.string(from: currentTime)
    }
}

#Preview {
    ClockDisplayView(
        currentTime: Date(),
        selectedFont: .system,
        fontSize: 80,
        fontColor: .white,
        onSettingsPressed: {}
    )
    .background(Color.black)
}