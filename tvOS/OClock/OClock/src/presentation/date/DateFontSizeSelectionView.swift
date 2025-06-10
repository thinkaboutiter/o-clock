//
//  DateFontSizeSelectionView.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI

struct DateFontSizeSelectionView: View {
    @Binding var fontSize: CGFloat
    @Environment(\.presentationMode) var presentationMode
    
    let fontSizes: [CGFloat] = {
        var sizes: [CGFloat] = []
        for i in 20...80 where i % 10 == 0 {
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
                            
                            Text("2025 June 10")
                                .font(.system(size: size, design: .default))
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
            .navigationTitle("Date Font Size")
            .navigationBarItems(trailing:
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

#Preview {
    @Previewable @State var fontSize: CGFloat = 40
    
    DateFontSizeSelectionView(fontSize: $fontSize)
}