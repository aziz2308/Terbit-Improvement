//
//  MainView.swift
//  Terbit-Improvement
//
//  Created by Umar Abdul Azis on 14/05/25.
//

import SwiftUI

struct MainView: View {
    @State var appRouter = AppRouter()
    @State var appStore = AppStore()
    
    var body: some View {
        NavigationStack(path: $appRouter.path) {
            HomeView()
                .navigationDestination(for: RouterEnum.self)
            {
                screen in switch screen {
                case .StreakView:
                    StreakView()
                case .ExtendedStreakView:
                    ExtendedStreakView()
                }
            }
        }
        .environment(appRouter)
        .environment(appStore)
    }
}
