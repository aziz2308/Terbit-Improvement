//
//  ExtDate.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 14/05/25.
//

import Foundation

extension Date {
    static var capitalizedFirstLettersOfWeekdays: [String] {
        var calendar = Calendar.current
        calendar.firstWeekday = calendar.firstWeekday
        var weekdays = calendar.shortWeekdaySymbols

        let firstWeekdayIndex = calendar.firstWeekday - 1
        if firstWeekdayIndex > 0 {
            let head = weekdays[firstWeekdayIndex..<weekdays.count]
            let tail = weekdays[0..<firstWeekdayIndex]
            weekdays = Array(head + tail)
        }

        return weekdays.map { $0.capitalized }
    }

    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    
    var firstWeekDayBeforeStart: Date {
       let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
       var numberFromPreviousMonth = startOfMonthWeekday - Calendar.current.firstWeekday
       if numberFromPreviousMonth < 0 {
           numberFromPreviousMonth += 7
       }
       return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        
        let firstDisplayDay = firstWeekDayBeforeStart
        var day = firstDisplayDay
        
        while day < startOfMonth {
            days.append(day)
            day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
        }
        
        for dayOffset in 0..<numberOfDaysInMonth {
            if let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth) {
                days.append(newDay)
            }
        }
        
        while days.count % 7 != 0 {
            if let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: days.last!) {
                days.append(nextDay)
            }
        }

        return days
    }

    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter
    }
}

extension Array where Element == Date {
    var recentWeekdaySymbol: [String] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        var dates = self.map { calendar.startOfDay(for: $0) }
        
        if !dates.contains(where: { calendar.isDate($0, inSameDayAs: today) }) {
            dates.append(today)
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E"

        return dates
            .sorted(by: { $1 > $0 })
            .prefix(5)
            .map { formatter.string(from: $0) }
    }
}
