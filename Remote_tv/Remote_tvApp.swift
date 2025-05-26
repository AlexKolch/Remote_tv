//
//  Remote_tvApp.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 25.05.2025.
//

import SwiftUI

@main
struct Remote_tvApp: App {
    @StateObject var vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            IntroView()
                .environmentObject(vm)
//            OnboardingView()
        }
    }
}
