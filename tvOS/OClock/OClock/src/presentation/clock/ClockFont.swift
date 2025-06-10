//
//  ClockFont.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI

enum ClockFont: String, CaseIterable {
    case system = "System"
    case monospace = "Monospace"
    case rounded = "Rounded"
    case serif = "Serif"
    
    func getFont(size: CGFloat) -> Font {
        switch self {
        case .system:
            return .system(size: size)
        case .monospace:
            return .system(size: size, design: .monospaced)
        case .rounded:
            return .system(size: size, design: .rounded)
        case .serif:
            return .system(size: size, design: .serif)
        }
    }
}