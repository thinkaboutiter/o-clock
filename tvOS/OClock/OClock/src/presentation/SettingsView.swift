//
//  SettingsView.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI

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
    @Previewable @State var selectedFont: ClockFont = .system
    @Previewable @State var fontSize: CGFloat = 80
    @Previewable @State var backgroundColor: Color = .black
    @Previewable @State var fontColor: Color = .white
    
    SettingsView(
        selectedFont: $selectedFont,
        fontSize: $fontSize,
        backgroundColor: $backgroundColor,
        fontColor: $fontColor
    )
}
