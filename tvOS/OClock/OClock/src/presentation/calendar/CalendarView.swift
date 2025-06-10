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

    init(selectedDate: Date = Date()) {
        self.selectedDate = selectedDate
    }

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

struct CalendarGridView: View {
    @Binding var selectedDate: Date
    
    private var calendar = Calendar.current
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
    private var days: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: selectedDate) else {
            return []
        }
        
        let monthFirstWeekday = calendar.component(.weekday, from: monthInterval.start)
        let daysToShow = monthFirstWeekday - 1
        
        var days: [Date] = []
        
        // Add previous month's trailing days
        for i in (1...daysToShow).reversed() {
            if let date = calendar.date(byAdding: .day, value: -i, to: monthInterval.start) {
                days.append(date)
            }
        }
        
        // Add current month's days
        var currentDate = monthInterval.start
        while currentDate < monthInterval.end {
            days.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        
        // Add next month's leading days to fill the grid
        let remainingDays = 42 - days.count // 6 rows × 7 days
        for i in 0..<remainingDays {
            if let date = calendar.date(byAdding: .day, value: i, to: monthInterval.end) {
                days.append(date)
            }
        }
        
        return days
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Weekday headers
            HStack(spacing: 0) {
                ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
            }
            
            // Calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 0) {
                ForEach(days, id: \.self) { date in
                    let isCurrentMonth = calendar.isDate(date, equalTo: selectedDate, toGranularity: .month)
                    let isToday = calendar.isDateInToday(date)
                    
                    Button(action: {
                        selectedDate = date
                    }) {
                        Text(dateFormatter.string(from: date))
                            .font(.system(size: 16))
                            .foregroundColor(isCurrentMonth ? .primary : .secondary)
                            .frame(width: 40, height: 40)
                            .background(isToday ? Color.blue.opacity(0.3) : Color.clear)
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CalendarView()
}
