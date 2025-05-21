//
//  Home.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 13/05/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(AppRouter.self) var appRouter
    @Environment(AppStore.self) var appStore
    @EnvironmentObject var streakManager: StreakManager
    
    @State private var StreakStatus: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                appRouter.push(.StreakView)
            })
            {
                VStack (spacing: 12){
                    HStack {
                        ZStack {
                            if streakManager.isTodayStreak {
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .offset(x: 0, y: 10)
                                    .foregroundStyle(Color(hex: "FEC762"))
                            }
                            
                            Image(systemName: "flame.fill")
                                .font(.system(size: 64, weight: .bold))
                                .foregroundStyle(streakManager.isTodayStreak ? Color(hex: "FF9D0A") : Color(hex: "CCBEA3"))
                        }
                        Text("\(streakManager.streakDates.count)")
                            .font(.system(size: 64, weight: .black))
                            .foregroundStyle(streakManager.isTodayStreak ? Color(hex: "FF9D0A") : Color(hex: "CCBEA3"))
                    }
                    
                    Text(streakManager.isTodayStreak ? "You’ve done great today!" : "Extend your streak!")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.6))
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "FFEDCC"))
                .cornerRadius(20)
                .padding(.horizontal)
                
            }
            
            
            ZStack(alignment: .topLeading) {
                Image(streakManager.isTodayStreak ? "Mascot-Cheerful" :"Mascot-Sad")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .offset(x: -10, y: -30)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Today’s Routine")
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("Manage")
                                .font(.custom("Nunito-SemiBold", size: 16))
                                .underline()
                                .foregroundStyle(Color(hex: "9F6816"))
                        }
                    }
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(Array(appStore.activities.enumerated()), id: \.element) { index, activity in
                                HStack(spacing: 16) {
                                    Text(("\(index + 1)"))
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(.black)
                                    
                                    HStack(spacing: 12) {
                                        ZStack {
                                            Circle()
                                                .frame(width: 35)
                                                .foregroundStyle(Color(hex: "FFEDCC"))
                                            Image(systemName: "\(activity.logo)")
                                                .foregroundStyle(.black)
                                        }
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("\(activity.title)")
                                                .font(.system(size: 14, weight: .regular))
                                            HStack(spacing: 4) {
                                                Image(systemName: "clock")
                                                    .font(.system(size: 12, weight: .light))
                                                Text("2 Minutes")
                                                    .font(.system(size: 12, weight: .light))
                                                    .foregroundStyle(.gray)
                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    if streakManager.isTodayStreak {
                                        Image(systemName: activity.isDone ? "checkmark.circle.fill" : "xmark.circle.fill")
                                            .foregroundStyle(Color(hex: "FFA500"))
                                            .font(.title2)
                                    }
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 21)
                        .fill(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 21)
                                .stroke(Color.orange, lineWidth: 1)
                        )
                )
                .padding(.top, 100)
                .padding(.horizontal)
                .padding(.bottom, 12)
            }
            
            Spacer()
            Button(action: {
                streakManager.addStreak(Date())
                appRouter.push(.ExtendedStreakView)
            }) {
                Text(streakManager.isTodayStreak ? "Do it again tomorrow!" : "START ROUTINE")
                    .font(.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(streakManager.isTodayStreak ? Color(hex: "767680").opacity(0.12) : Color(hex: "FFA500"))
                    .foregroundStyle(streakManager.isTodayStreak ? Color(hex: "000000").opacity(0.2) : Color(hex: "0C0A08"))
                    .cornerRadius(12)
            }
            .disabled(streakManager.isTodayStreak)
            .padding(.horizontal)
            .padding(.bottom)
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        streakManager.removeTodayStreak()
                    }) {
                        Text("Settings")
                    }
                } label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color(hex: "BCBCBC"))
                }
            }
        }
        .onAppear {
            streakManager.updateDays()
        }
    }
}
