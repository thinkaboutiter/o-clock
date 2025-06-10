//
//  CalendarView.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: previousMonth) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text(monthYearString(from: selectedDate))
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Button(action: showYearPicker) {
                            Text("Change Year")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: nextMonth) {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                Spacer()
                
                CalendarGridView(selectedDate: $selectedDate)
                
                Spacer()
                
                HStack {
                    Button("Today") {
                        selectedDate = Date()
                    }
                    .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.blue)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Calendar")
            .navigationBarHidden(true)
        }
    }
    
    private func previousMonth() {
        selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate) ?? selectedDate
    }
    
    private func nextMonth() {
        selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate) ?? selectedDate
    }
    
    private func showYearPicker() {
        // This could be expanded to show a year picker
        // For now, we'll just jump to current year
        selectedDate = Date()
    }
    
    private func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarView()
}