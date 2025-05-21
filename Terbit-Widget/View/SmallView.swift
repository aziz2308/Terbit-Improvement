//
//  SmallView.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 19/05/25.
//
import SwiftUI

struct SmallWidgetView: View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            VStack (spacing: 6) {
                HStack (spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 28, weight: .black))
                        .foregroundStyle(entry.isDone ? Color(hex: "FFA500") : Color(hex: "FEDCB3"))
                    Text("\(entry.streak.count)")
                        .font(.system(size: 36, weight: .black))
                        .foregroundStyle(entry.isDone ? Color(hex: "FFA500") : Color(hex: "FEDCB3"))
                }
                .padding(.top, 6)
                
                Text(entry.isDone ? "You're awesome!" : "Extend your streak!")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(hex: "FFF3E5"))
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            Image(entry.isDone ? "Cheerful" : "Sad" )
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .offset(x: 0, y: 58)
        }
        
        .containerBackground(
            LinearGradient(
                colors: entry.isDone ?
                    [Color(hex: "4E221B"), Color(hex: "FF8C00")] :
                    [Color(hex: "F38601"), Color(hex: "FFCA8A")],
                startPoint: .top,
                endPoint: entry.isDone ? UnitPoint(x: 0.5, y: 0.75) : .bottom
            ),
            for: .widget
        )
    }
}
