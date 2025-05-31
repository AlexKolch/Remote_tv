//
//  OnboardingView.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 25.05.2025.
//
import SwiftUI

struct OnboardingView: View {
    @State var onboardingState: Int = 0
    @State var toggleIsOn: Bool = false
    @EnvironmentObject var vm: IntroViewModel
    
    var body: some View {
        VStack() {
                switch onboardingState {
                case 0:
                    firstOnboard
                        .padding(.top, 24)
                    Spacer()
                    OnboardingSheet(toggleIsOn: $toggleIsOn, onboardingState: $onboardingState, title: "Smart TV control", description: "Easiest way to control your smart TV with your phone")
                case 1:
                    secondOnboard
                        .padding(.top, 30)
                    Spacer()
                    OnboardingSheet(toggleIsOn: $toggleIsOn, onboardingState: $onboardingState, title: "Your feedback matters", description: "Your feedback is highly appreciated to make your experience smoother")
                case 2:
                    ZStack(alignment: .top) {
                        thirdOnboard
                            .padding(.top, 17)
                            .padding(.horizontal, 33)
                
                        OnboardingSheet(toggleIsOn: $toggleIsOn, onboardingState: $onboardingState,
                                        title: "Remote always at hand",
                                        description: "No more wasting time looking for the remote control over and over again")
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                    .onAppear {
                        vm.requestAppReview()
                    }
                case 3:
                    ZStack(alignment: .top) {
                        fourthOnboard
                            .padding(.top, 12.5)
                            .padding(.horizontal, 9)

                        if !vm.isLoading {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12.73, height: 12.73)
                                .font(Font.title.weight(.bold))
                                .foregroundStyle(.white)
                                .frame(width: 56, height: 56, alignment: .center)
                                .offset(x: 158)
                        }
                        
                        OnboardingSheet(toggleIsOn: $toggleIsOn, onboardingState: $onboardingState,
                                        title: "A must for Smart TV",
                                        description: toggleIsOn == false ? "Subscribe to unlock all the features,\n just $4.99/week" : "Subscribe to unlock all the features,\n just $4.99/week + 3-day free trial")
                            .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .bottom)
                    }

                    
                default:
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.green)
                    }
          
        }
        .background(LinearGradient.addLinerGradient())
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    OnboardingView()
        .environmentObject(IntroViewModel())
}

private extension OnboardingView {
    
    var firstOnboard: some View {
        ZStack(alignment: .top) {
            Image(.tv)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 470, height: 252)
            Image(.phoneRemote)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 335, height: 340)
                .offset(y: 149)
        }
    }
    
    var secondOnboard: some View {
        Image(.secondBoard)
            .resizable()
            .frame(width: 320, height: 361)
            .aspectRatio(contentMode: .fit)
    }
    
    var thirdOnboard: some View {
        ZStack(alignment: .top) {
            Image(.thirdBoard)
                .resizable()
                .scaledToFit()
            Image(.mockup)
                .resizable()
                .scaledToFit()
                .offset(y: -16)
                .scaleEffect(0.88)
        }
    }
    
    var fourthOnboard: some View {
        ZStack(alignment: .top) {
            Image(.tvLG)
                .resizable()
                .scaledToFit()
                .frame(width: 356, height: 216)
            Image(.iPhoneHand)
                .resizable()
                .scaledToFit()
                .offset(x: -10, y: -65)
        }
    }
}

