//
//  ContentView.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 25.05.2025.
//

import SwiftUI

struct IntroView: View {
    @EnvironmentObject var vm: ViewModel
//    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
              
        if vm.currentUserSignedIn {
//                  ProfileView()
//                      .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
              } else {
                  OnboardingView()
//                      .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                  
              }
              
    }
}

#Preview {
    IntroView()
        .environmentObject(ViewModel())
}
