//
//  Utils.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 13/05/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

//struct StreakNumberFormat: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.system(size: 64, weight: .black))
//            .foregroundColor(Color(hex: "FF9D0A"))
//    }
//}
//
//struct StreakLogoFormat: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.system(size: 64, weight: .bold))
//            .foregroundColor(Color(hex: "FF9D0A"))
//    }
//}

let activities: [ActivityModel] = [
        ActivityModel(
            title: "Mindful Breathing",
            duration: 2,
            logo: "wind",
            isDone: true
        ),
        ActivityModel(
            title: "Set Focus",
            duration: 2,
            logo: "applepencil.and.scribble",
            isDone: true
        ),
        ActivityModel(
            title: "Hydrate Gently",
            duration: 1,
            logo: "cup.and.saucer",
            isDone: true
        ),
        ActivityModel(
            title: "Stretch Your Body",
            duration: 2,
            logo: "figure.strengthtraining.functional",
            isDone: true
        ),
        ActivityModel(
            title: "Short Walk",
            duration: 3,
            logo: "figure.walk",
            isDone: true
        )
]
