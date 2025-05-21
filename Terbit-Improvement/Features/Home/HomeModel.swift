//
//  HomeModel.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 16/05/25.
//

struct RoutineModel {
    let activities: ActivityModel
    let index: Int
}

struct ActivityModel: Codable, Hashable {
    let title: String
    let duration: Int
    let logo: String
    let isDone: Bool
}
