//
//  StreakManagerWidget.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 19/05/25.
//

import Foundation

class StreakManagerWidget {
    private let userDefaults = UserDefaults(suiteName: "group.com.Azis.Terbit-Improvement")
    private let streakKey = "streakDates"
    let calendar = Calendar.current

    var streakDates: [Date] {
        guard let data = userDefaults?.array(forKey: streakKey) as? [Double] else {
            return []
        }
        return data.map { Date(timeIntervalSince1970: $0) }
    }

    var isTodayStreak: Bool {
        streakDates.contains { calendar.isDate($0, inSameDayAs: Date()) }
    }
}
