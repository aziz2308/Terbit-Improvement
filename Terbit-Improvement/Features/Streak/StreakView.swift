//
//  StreakView.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 14/05/25.
//

import SwiftUI
import Foundation

struct StreakView: View {
    @EnvironmentObject private var streakManager: StreakManager
    @Environment(AppRouter.self) private var appRouter
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    
    var body: some View {
        VStack (spacing: 24) {
            VStack (alignment: .center ,spacing: 40){
                VStack (spacing: 8) {
                    HStack(spacing: 12) {
                        ZStack {
                            
                            if streakManager.isTodayStreak {
                                Circle()
                                    .frame(width: 55, height: 55)
                                    .offset(x: 0, y: 20)
                                    .foregroundStyle(Color(hex: "FEC762"))
                            }
                            
                            Image(systemName: "flame.fill")
                                .font(.system(size: 96, weight: .black))
                                .foregroundStyle(streakManager.isTodayStreak ? Color(hex: "FF9D0A") : Color(hex: "CCBEA3"))
                        }
                        Text("\(streakManager.streakDates.count)")
                            .font(.system(size: 96, weight: .black))
                            .foregroundStyle(streakManager.isTodayStreak ? Color(hex: "FF9D0A") : Color(hex: "CCBEA3"))
                    }
                    .padding(.top, 48)
                    
                    Text("Day Streak!")
                        .font(.system(size: 24, weight: .black))
                        .foregroundStyle(streakManager.isTodayStreak ? Color(hex: "FF9D0A") : Color(hex: "CCBEA3"))
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                
                Text(streakManager.isTodayStreak ? "Keep going! Your consistency is inspiring!" : "It’s never too late to extend your streak!")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(hex: "0C0A08"))
                    .padding()

            }
            
            VStack {
                HStack (spacing: 32) {
                    Text(streakManager.currentMonth, formatter: Date().monthFormatter)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: { streakManager.goToPreviousMonth(); streakManager.updateDays() }) {
                        Image(systemName: "chevron.left")
                    }
                    .tint(Color.gray)
    
                    Button(action: { streakManager.goToNextMonth(); streakManager.updateDays() }) {
                        Image(systemName: "chevron.right")
                    }
                    .tint(Color.gray)
                }
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        ForEach(streakManager.daysOfWeek.indices, id: \.self) { index in
                            Text(streakManager.daysOfWeek[index])
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(Color(hex: "C4C4C7"))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(streakManager.days, id: \.self) { date in
                            CalendarStreakView(
                                date: date,
                                isSelected: Calendar.current.isDate(date, inSameDayAs: streakManager.selectedDate ?? Date()),
                                isStreak: streakManager.streakDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }),
                                isDifferentMonth:
                                    date.monthInt != streakManager.currentMonth.monthInt,
                                isToday: Calendar.current.isDateInToday(date)
                            )
//                            .onTapGesture {
//                                streakManager.selectedDate = date
//                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .frame(minHeight: 310)
                }
                .background(
                    RoundedRectangle(cornerRadius: 21)
                        .fill(Color.white)
                        .stroke(Color(hex: "C4C4C7"), lineWidth: 1)
                )
                .padding()
            }
            .padding(24)
            .background(.white)
        }
        .navigationTitle("Streak")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    appRouter.popToRoot()
                }) {
                    Image(systemName: "xmark")
                }
                .tint(Color.primary)
            }
        }
        .background(Color(hex: "FFEDCC"))
        .onAppear {
            streakManager.updateDays()
        }
    }
}
