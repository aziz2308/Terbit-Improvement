//
//  CalendarStreakView.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 14/05/25.
//

import SwiftUI

struct CalendarStreakView: View {
    let date: Date
    let isSelected: Bool
    let isStreak: Bool
    let isDifferentMonth: Bool
    let isToday: Bool
    
    var body: some View {
        ZStack {
            switch (isDifferentMonth, isToday, isStreak) {
            case (true, _, _):
                EmptyView()

            case (false, true, true):
                ZStack {
                    Circle()
                        .fill(Color(hex: "FF9500"))
                        .frame(width: 38, height: 38)
                    Image(systemName: "flame.fill")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                }

            case (false, false, true):
                ZStack {
                    Circle()
                        .fill(Color(hex: "FFEDCC"))
                        .frame(width: 36, height: 36)
                    Text("\(Calendar.current.component(.day, from: date))")
                        .foregroundStyle(.primary)
                        .font(.system(size: 16))
                }
                
            case (false, true, false):
                ZStack {
                    Circle()
                        .fill(Color(hex: "CCCCCC"))
                        .frame(width: 38, height: 38)
                    Text("\(Calendar.current.component(.day, from: date))")
                        .foregroundStyle(.primary)
                        .font(.system(size: 16))
                }

            case (false, false, false):
                Text("\(Calendar.current.component(.day, from: date))")
                    .foregroundStyle(.primary)
                    .font(.system(size: 16))
            
            }
        }
        .frame(width: 40, height: 40)
        .background(Color.clear)
        .clipShape(Circle())
    }
}
