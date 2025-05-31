//
//  ContentView.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 25.05.2025.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var vm: IntroViewModel
    
    var body: some View {
        if vm.currentUserSignedIn {
            DeviceConnection()
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    IntroView()
        .environmentObject(IntroViewModel())
}
