//
//  FontSizeSelectionView.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI

struct ClockFontSizeSelectionView: View {
    @Binding var fontSize: CGFloat
    @Environment(\.presentationMode) var presentationMode
    
    let fontSizes: [CGFloat] = {
        var sizes: [CGFloat] = []
        for i in 120...360 where i % 30 == 0 {
            sizes.append(CGFloat(i))
        }
        return sizes
    }()

    var body: some View {
        NavigationView {
            List {
                ForEach(fontSizes, id: \.self) { size in
                    Button(action: {
                        fontSize = size
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text("\(Int(size)) pt")
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text("12:34")
                                .font(.system(size: size * 0.3, design: .monospaced))
                                .foregroundColor(.primary)
                            
                            if fontSize == size {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                                    .padding(.leading, 10)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationTitle("Clock Font Size")
            .navigationBarItems(trailing:
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

#Preview {
    @Previewable @State var fontSize: CGFloat = 80
    
    ClockFontSizeSelectionView(fontSize: $fontSize)
}
