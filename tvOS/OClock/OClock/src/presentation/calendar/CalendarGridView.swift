//
//  CalendarGridView.swift
//  OClock
//
//  Created by boyan.yankov on 2025-06-10.
//

import SwiftUI

struct CalendarGridView: View {
    @Binding var selectedDate: Date
    let backgroundColor: Color
    let fontColor: Color
    
    init(selectedDate: Binding<Date>, backgroundColor: Color, fontColor: Color) {
        self._selectedDate = selectedDate
        self.backgroundColor = backgroundColor
        self.fontColor = fontColor
    }
    
    private var calendar = Calendar.current
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
    private var monthDays: [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: selectedDate) else {
            return []
        }
        
        let firstDayOfMonth = monthInterval.start
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        let numberOfDaysInMonth = calendar.component(.day, from: calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfMonth)!)
        
        var days: [Date?] = []
        
        // Add empty spaces for days before the first day of the month
        for _ in 1..<firstWeekday {
            days.append(nil)
        }
        
        // Add all days of the current month
        for day in 1...numberOfDaysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
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
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(fontColor.opacity(0.7))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
            }
            
            // Calendar grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                ForEach(Array(monthDays.enumerated()), id: \.offset) { index, date in
                    if let date = date {
                        let isToday = calendar.isDateInToday(date)
                        
                        Button(action: {
                            selectedDate = date
                        }) {
                            Text(dateFormatter.string(from: date))
                                .font(.system(size: 24))
                                .fontWeight(isToday ? .bold : .medium)
                                .foregroundColor(isToday ? backgroundColor : fontColor)
                                .frame(width: 60, height: 60)
                                .background(isToday ? fontColor : Color.clear)
                                .cornerRadius(30)
                        }
                        .buttonStyle(PlainButtonStyle())
                    } else {
                        // Empty space for days not in current month
                        Text("")
                            .frame(width: 60, height: 60)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedDate = Date()
        
        var body: some View {
            CalendarGridView(
                selectedDate: $selectedDate,
                backgroundColor: .black,
                fontColor: .white
            )
        }
    }
    
    return PreviewWrapper()
}