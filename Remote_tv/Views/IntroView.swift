//
//  ContentView.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 25.05.2025.
//

import SwiftUI

struct IntroView: View {
    @StateObject var viewModel = IntroViewModel()
    
    var body: some View {
        if viewModel.currentUserSignedIn {
            DeviceConnection()
        } else {
            OnboardingView()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    IntroView()
        .environmentObject(IntroViewModel())
}
