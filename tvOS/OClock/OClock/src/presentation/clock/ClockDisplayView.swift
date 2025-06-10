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
    
    var body: some View {
        Text(timeString)
            .font(selectedFont.getFont(size: fontSize).weight(.medium))
            .foregroundColor(fontColor)
            .monospacedDigit()
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
        fontColor: .white
    )
    .background(Color.black)
}