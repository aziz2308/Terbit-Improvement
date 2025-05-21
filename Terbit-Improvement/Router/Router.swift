//
//  Router.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 14/05/25.
//

import Observation
import SwiftUI

@Observable
class BaseRouter<T: Equatable> {
    var path: [T] = []
    
    var tabBarVisibility: Visibility = .hidden
    
    func push(_ screen: T) {
        path.append(screen)
    }
    
    func popToRoot() {
        path.removeAll()
    }
}

class AppRouter: BaseRouter<RouterEnum> {}

enum RouterEnum: Hashable, Equatable {
    case StreakView
    case ExtendedStreakView
}
