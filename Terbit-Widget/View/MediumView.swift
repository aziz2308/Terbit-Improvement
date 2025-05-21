//
//  MediumView.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 19/05/25.
//
import SwiftUI

struct MediumWidgetView: View {
    var entry: Provider.Entry
    
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 12){
                HStack (spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 36, weight: .black))
                        .foregroundStyle(entry.isDone ? Color(hex: "FFA500") : Color(hex: "FEDCB3"))
                    Text("\(entry.streak.count)")
                        .font(.system(size: 48, weight: .black))
                        .foregroundStyle(entry.isDone ? Color(hex: "FFA500") : Color(hex: "FEDCB3"))
                }
                .padding(.horizontal, 15)
                .offset(y: 12)
                
                HStack (alignment: .center, spacing: 0) {
                    ForEach(Array(entry.streak.recentWeekdaySymbol.enumerated()), id: \.offset) { index, day in
                        VStack(alignment: .center, spacing: 5) {
                            Text("\(day)")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(Color(hex: "FFF3E5"))

                            ZStack {
                                if index == entry.streak.recentWeekdaySymbol.count - 1 {
                                    if entry.isDone {
                                        Color(hex: "FFF3E5")
                                            .clipShape(Circle())
                                            .padding(.horizontal, 10)
                                        
                                        Image(systemName: "checkmark.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                            .foregroundStyle(Color(hex: "FFA500"))
                                    } else {
                                        Circle()
                                            .fill(Color(hex: "808080").opacity(0.4))
                                            .frame(width: 25, height: 25)
                                            .padding(.horizontal, 10)
                                    }
                                } else {
                                    Color(hex: "FFF3E5")
                                        .clipShape(Circle())
                                        .padding(.horizontal, 5)
                                    
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .foregroundStyle(entry.isDone ? Color(hex: "FFA500") : Color(hex: "FEDCB3"))
                                }
                            }
                        }
                }
            }
            .padding()
        }
        .offset(x: -12)
            
        ZStack (alignment: .center){
            Text(entry.isDone ? "You're awesome!" : "Extend Streak?")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color(hex: "FFF3E5"))
                .offset(y: -30)
                
            Image(entry.isDone ? "Cheerful" : "Sad")
                .resizable()
                .frame(width: 100, height: 100)
                .offset(x: 0, y: 44)
        }
        }
        .containerBackground(
            LinearGradient(
                colors: entry.isDone ?
                    [Color(hex: "4E221B"), Color(hex: "FF8C00")] :
                    [Color(hex: "F38601"), Color(hex: "FFCA8A")],
                startPoint: entry.isDone ? .top : .center,
                endPoint: entry.isDone ? UnitPoint(x: 0.5, y: 0.75) : .bottom
            ), for: .widget)
    }
}
