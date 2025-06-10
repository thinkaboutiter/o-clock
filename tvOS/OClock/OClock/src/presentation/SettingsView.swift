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
    @Binding var dateFontSize: CGFloat
    @Binding var backgroundColor: Color
    @Binding var fontColor: Color
    @Environment(\.presentationMode) var presentationMode
    @State private var showFontSizeSelection = false
    
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
                    
                    NavigationLink(destination: FontSizeSelectionView(fontSize: $fontSize)) {
                        HStack {
                            Text("Time Font Size")
                            Spacer()
                            Text("\(Int(fontSize)) pt")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    NavigationLink(destination: FontSizeSelectionView(fontSize: $dateFontSize)) {
                        HStack {
                            Text("Date Font Size")
                            Spacer()
                            Text("\(Int(dateFontSize)) pt")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section("Background Color") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(backgroundColors, id: \.self) { color in
                                Circle()
                                    .fill(color)
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Circle()
                                            .stroke(backgroundColor == color ? Color.white : Color.clear, lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        backgroundColor = color
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                Section("Font Color") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(fontColors, id: \.self) { color in
                                Circle()
                                    .fill(color)
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Circle()
                                            .stroke(fontColor == color ? Color.blue : Color.clear, lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        fontColor = color
                                    }
                            }
                        }
                        .padding(.horizontal)
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
    @Previewable @State var dateFontSize: CGFloat = 40
    @Previewable @State var backgroundColor: Color = .black
    @Previewable @State var fontColor: Color = .white
    
    SettingsView(
        selectedFont: $selectedFont,
        fontSize: $fontSize,
        dateFontSize: $dateFontSize,
        backgroundColor: $backgroundColor,
        fontColor: $fontColor
    )
}
