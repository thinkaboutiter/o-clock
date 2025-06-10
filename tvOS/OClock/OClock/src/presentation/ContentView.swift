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
                    .font(selectedFont.getFont(size: fontSize).weight(.medium))
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

struct SettingsView: View {
    @Binding var selectedFont: ClockFont
    @Binding var fontSize: CGFloat
    @Binding var backgroundColor: Color
    @Binding var fontColor: Color
    @Environment(\.presentationMode) var presentationMode
    
    let backgroundColors: [Color] = [
        .black, .white, .gray, .blue,
        .red, .green, .orange, .purple,
        .yellow, .pink, .indigo, .mint
    ]
    
    let fontColors: [Color] = [
        .white, .black, .gray, .blue,
        .red, .green, .orange, .purple,
        .yellow, .pink, .indigo, .mint
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Font") {
                    Picker("Font Style", selection: $selectedFont) {
                        ForEach(ClockFont.allCases, id: \.self) { font in
                            Text(font.rawValue).tag(font)
                        }
                    }
                    
                    HStack {
                        Text("Font Size: \(Int(fontSize))")
                        Spacer()
                        Button("-") {
                            if fontSize > 40 {
                                fontSize -= 5
                            }
                        }
                        .padding(.horizontal)
                        Button("+") {
                            if fontSize < 120 {
                                fontSize += 5
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                Section("Background Color") {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                        ForEach(backgroundColors, id: \.self) { color in
                            Rectangle()
                                .fill(color)
                                .frame(height: 60)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(backgroundColor == color ? Color.white : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    backgroundColor = color
                                }
                        }
                    }
                }
                
                Section("Font Color") {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                        ForEach(fontColors, id: \.self) { color in
                            Rectangle()
                                .fill(color)
                                .frame(height: 60)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(fontColor == color ? Color.gray : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    fontColor = color
                                }
                        }
                    }
                }
                
                Section("Preview") {
                    HStack {
                        Spacer()
                        Text("12:34:56")
                            .font(selectedFont.getFont(size: fontSize * 0.3).weight(.medium))
                            .foregroundColor(fontColor)
                            .padding()
                            .background(backgroundColor)
                            .cornerRadius(8)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Clock Settings")
            .navigationBarItems(trailing: 
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

#Preview {
    ContentView()
}
