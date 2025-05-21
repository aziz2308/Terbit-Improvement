//
//  Store.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 16/05/25.
//

import Observation

@Observable
class AppStore {
    
    var activities: [ActivityModel] = [
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
}
