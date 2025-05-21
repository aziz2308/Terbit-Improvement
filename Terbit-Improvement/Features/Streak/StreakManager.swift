//
//  StreakCalendarManager.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 14/05/25.
//
import SwiftUI
import WidgetKit
import Foundation

class StreakManager: ObservableObject {
    private let userDefaults = UserDefaults(suiteName: "group.com.Azis.Terbit-Improvement")
    private let streakKey = "streakDates"

    @Published var currentMonth: Date = Date()
    @Published var selectedDate: Date?
    @Published var days: [Date] = []

    let calendar = Calendar.current

    var streakDates: [Date] {
        get {
            guard let data = userDefaults?.array(forKey: streakKey) as? [Double] else {
                let defaultDates = (1...18).compactMap { day in
                    Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: day))
                }
                
                let timestamps = defaultDates.map { $0.timeIntervalSince1970 }
                userDefaults?.set(timestamps, forKey: streakKey)
                return defaultDates
            }
            return data.map { Date(timeIntervalSince1970: $0) }
        }
        set {
            let timestamps = newValue.map { $0.timeIntervalSince1970 }
            userDefaults?.set(timestamps, forKey: streakKey)
        }
    }

    var isTodayStreak: Bool {
        streakDates.contains { calendar.isDate($0, inSameDayAs: Date()) }
    }

    func updateDays() {
        days = currentMonth.calendarDisplayDays
    }

    func addStreak(_ date: Date) {
        let dateOnly = calendar.startOfDay(for: date)
        var currentStreak = streakDates

        let alreadyExists = currentStreak.contains {
            calendar.isDate($0, inSameDayAs: dateOnly)
        }

        if !alreadyExists {
            currentStreak.append(dateOnly)
            streakDates = currentStreak.sorted()
            updateWidget()
        }
    }
    
    func removeTodayStreak() {
        let today = calendar.startOfDay(for: Date())
        streakDates = streakDates.filter { !calendar.isDate($0, inSameDayAs: today) }
        updateWidget()
    }


    func updateWidget() {
        WidgetCenter.shared.reloadTimelines(ofKind: "Terbit_Widget")
    }

    func goToPreviousMonth() {
        if let prevMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            currentMonth = prevMonth
        }
    }

    func goToNextMonth() {
        if let nextMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            currentMonth = nextMonth
        }
    }
    
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
}
