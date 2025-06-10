//
//  DateDisplayView.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI

struct DateDisplayView: View {
    let currentTime: Date
    let selectedFont: ClockFont
    let dateFontSize: CGFloat
    let fontColor: Color
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(formatDate(currentTime))
                .font(selectedFont.getFont(size: dateFontSize).weight(.regular))
                .foregroundColor(fontColor)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MMMM dd"
        return formatter.string(from: date)
    }
}

#Preview {
    DateDisplayView(
        currentTime: Date(),
        selectedFont: .system,
        dateFontSize: 40,
        fontColor: .white,
        onTap: {}
    )
}