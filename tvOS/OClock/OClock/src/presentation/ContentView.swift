//
//  ContentView.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI

struct ContentView: View {
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
            
            VStack(spacing: 40) {
                Text(timeString)
                    .font(selectedFont.font.weight(.medium))
                    .fontSize(fontSize)
                    .foregroundColor(fontColor)
                    .monospacedDigit()
                
                Button("Settings") {
                    showSettings.toggle()
                }
                .foregroundColor(fontColor.opacity(0.7))
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
    
    private var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        return formatter.string(from: currentTime)
    }
}

enum ClockFont: String, CaseIterable {
    case system = "System"
    case monospace = "Monospace"
    case rounded = "Rounded"
    case serif = "Serif"
    
    var font: Font {
        switch self {
        case .system:
            return .system(size: 80)
        case .monospace:
            return .system(size: 80, design: .monospaced)
        case .rounded:
            return .system(size: 80, design: .rounded)
        case .serif:
            return .system(size: 80, design: .serif)
        }
    }
}

extension Font {
    func fontSize(_ size: CGFloat) -> Font {
        return .system(size: size)
    }
}

struct SettingsView: View {
    @Binding var selectedFont: ClockFont
    @Binding var fontSize: CGFloat
    @Binding var backgroundColor: Color
    @Binding var fontColor: Color
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section("Font") {
                    Picker("Font Style", selection: $selectedFont) {
                        ForEach(ClockFont.allCases, id: \.self) { font in
                            Text(font.rawValue).tag(font)
                        }
                    }
                    
                    VStack {
                        Text("Font Size: \(Int(fontSize))")
                        Slider(value: $fontSize, in: 40...120, step: 5)
                    }
                }
                
                Section("Colors") {
                    ColorPicker("Background Color", selection: $backgroundColor)
                    ColorPicker("Font Color", selection: $fontColor)
                }
                
                Section("Preview") {
                    HStack {
                        Spacer()
                        Text("12:34:56")
                            .font(selectedFont.font.weight(.medium))
                            .fontSize(fontSize * 0.3)
                            .foregroundColor(fontColor)
                            .padding()
                            .background(backgroundColor)
                            .cornerRadius(8)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Clock Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
