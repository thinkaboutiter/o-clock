//
//  FontSizeSelectionView.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI

struct FontSizeSelectionView: View {
    @Binding var fontSize: CGFloat
    @Environment(\.presentationMode) var presentationMode
    
    let fontSizes: [CGFloat] = [40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fontSizes, id: \.self) { size in
                    HStack {
                        Text("\(Int(size)) pt")
                            .font(.system(size: 20))
                        
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
                    .contentShape(Rectangle())
                    .onTapGesture {
                        fontSize = size
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Font Size")
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
    
    FontSizeSelectionView(fontSize: $fontSize)
}