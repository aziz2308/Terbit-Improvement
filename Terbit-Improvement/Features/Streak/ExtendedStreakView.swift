//
//  ExtendedStreakView.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 15/05/25.
//

import SwiftUI

import SwiftUI

struct ExtendedStreakView: View {
    @Environment(AppRouter.self) var appRouter
    @EnvironmentObject var streakManager: StreakManager

    @State private var showText = false
    @State private var isHighlighted = false
    @State private var animatedCount: Int = 0
    @State private var showCount = false


    var body: some View {
        VStack {
            VStack(spacing: 8) {
                ZStack {
                    if showText {
                        Circle()
                            .frame(width: 60, height: 60)
                            .offset(x: 0, y: 20)
                            .foregroundStyle(Color(hex: "FEC762"))
//                            .transition(.opacity.combined(with: .scale))
                            .animation(.easeInOut(duration: 0.8), value: isHighlighted)
                    }

                    Image(systemName: "flame.fill")
                        .font(.system(size: 128, weight: .bold))
                        .foregroundStyle(isHighlighted ? Color(hex: "FF9D0A") : Color(hex: "CCBEA3"))
                        .animation(.easeInOut(duration: 0.8), value: isHighlighted)
                }

                Text("\(animatedCount)")
                        .font(.system(size: 96, weight: .black))
                        .foregroundStyle(isHighlighted ? Color(hex: "FF9D0A") : Color(hex: "CCBEA3"))
                        .contentTransition(.numericText(countsDown: false))
                        .animation(.easeInOut(duration: 0.25), value: animatedCount)
            }
            .padding()

            VStack(spacing: 8) {
               Text("You are on fire!")
                   .font(.system(size: 24, weight: .bold))
                   .foregroundStyle(showText ? .black : Color(hex: "FFFFFF"))
                   .animation(.easeInOut(duration: 0.6), value: showText)

               Text("You have completed the routine for \(streakManager.streakDates.count) days!")
                   .font(.system(size: 16, weight: .regular))
                   .foregroundStyle(showText ? .black : Color(hex: "FFFFFF"))
                   .animation(.easeInOut(duration: 0.6), value: showText)
           }
           .padding()

           Text("Tap anywhere to continue")
               .font(.system(size: 16, weight: .regular))
               .foregroundStyle(showText ? Color(hex: "CCBEA3") : .white)
               .padding()
               .offset(x: 0, y: 150)
               .animation(.easeInOut(duration: 0.6), value: showText)
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            appRouter.popToRoot()
        }
        .onAppear {
            let target = streakManager.streakDates.count
            
            let startCount = max(target - 10, 1)
        
            animatedCount = startCount
            
            for i in 0...(target - startCount) {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.1) {
                    withAnimation {
                        animatedCount = startCount + i
                    }
                }
                }

            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(target - startCount) * 0.1 + 0.15) {
                withAnimation(.easeIn(duration: 0.5)) {
                    showText = true
                }
                isHighlighted = true
                }
        }
    }
}

