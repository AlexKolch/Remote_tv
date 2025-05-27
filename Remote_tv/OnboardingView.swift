//
//  OnboardingView.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 25.05.2025.
//

import SwiftUI

struct OnboardingView: View {
    @State var onboardingState: Int = 0
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack() {
                switch onboardingState {
                case 0:
                    firstOnboard
                        .padding(.top, 24)
                    Spacer()
                    OnboardingSheet(onboardingState: $onboardingState, title: "Smart TV control", description: "Easiest way to control your smart TV with your phone")
                case 1:
                    secondOnboard
                        .padding(.top, 30)
                    Spacer()
                        OnboardingSheet(onboardingState: $onboardingState, title: "Your feedback matters", description: "Your feedback is highly appreciated to make your experience smoother")
                case 2:
                    ZStack(alignment: .top) {
                        thirdOnboard
                            .padding(.top, 17)
                            .padding(.horizontal, 33)
                
                        OnboardingSheet(onboardingState: $onboardingState, title: "Remote always at hand", description: "No more wasting time looking for the remote control over and over again")
                            .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .bottom)
                    }
                    .onAppear {
                        vm.requestAppReview()
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
}

struct OnboardingSheet: View {
    @EnvironmentObject var vm: ViewModel
    @State var toggleIsOn: Bool = false
    @Binding var onboardingState: Int
    
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 24.0) {
            VStack(alignment: .center, spacing: 16.0) {
                Text(title)
                    .fontWithLineHeight(font: .inter, fontSize: 28, letterSpacing: 0.02, lineHeight: 34)
                    .bold()
                    .foregroundStyle(.white)
                
                Text(description)
                    .font(FontBuilder.description.font)
                    .tracking(FontBuilder.description.tracking)
                    .lineSpacing(1.4)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                if onboardingState == 4 {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.bglevel2)
                                .frame(maxWidth: .infinity)
                                .frame(height: 63)
                            
                            HStack {
                                Toggle(isOn: $toggleIsOn) {
                                    if toggleIsOn {
                                        Text("3-day free trial enabled")
                                            .fontWithLineHeight(font: .inter, fontSize: 16, letterSpacing: 0.02, lineHeight: 24)
                                            .foregroundStyle(.white)
                                    } else {
                                        VStack(alignment: .leading, spacing: 0) {
                                            Text("Not sure yet?")
                                                .fontWithLineHeight(font: .inter, fontSize: 16, letterSpacing: 0.02, lineHeight: 22)
                                                .foregroundStyle(.white)
                                            Text("Enable a 3-day free trial")
                                                .fontWithLineHeight(font: .inter, fontSize: 12, letterSpacing: 0.02, lineHeight: 17)
                                                .foregroundStyle(.white.opacity(0.6))
                                            
                                        }
                                        .padding(.vertical, 12)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 39)
                                    }
                                }
                                .tint(LinearGradient.addLinerGradient(startPoint: .leading, endPoint: .trailing))
                                .padding(.trailing, 12)
                                .padding(.leading, 16)
                            }
                        }
               
                }
            }
            
            
            Button {
                handleNextButtonPressed()
            } label: {
                Text(toggleIsOn ? "Try free" : "Continue")
                    .foregroundStyle(.white)
                    .font(.inter, size: 18).bold()
                    .frame(maxWidth: .infinity)
                    .frame(height: 64)
                    .background(LinearGradient.addLinerGradient(startPoint: .leading, endPoint: .trailing))
                    .clipShape(.rect(cornerRadius: 12))
            }
            
            HStack() {
                Group {
                    Text("Privacy Policy")
                    Text("Restore")
                    Text("Terms of Use")
                }
                .font(FontBuilder.infoBtn.font)
                .tracking(FontBuilder.infoBtn.tracking)
                .lineSpacing(FontBuilder.infoBtn.lineSpacing)
                .padding(.vertical, FontBuilder.infoBtn.verticalPadding)
                .frame(height: 40)
                .frame(minWidth: 98.33, alignment: .center)
                .padding(.horizontal, 8)
                .padding(.vertical, 11.5)
                .foregroundStyle(.white.opacity(0.6))
            }
            
        }
        .frame(height: onboardingState < 4 ? 279 : 358)
//        .background(.white)
        .padding(.top, 32)
        .padding([.horizontal, .bottom], 16)
        .background(Color.bglevel1)
        .clipShape(.rect(cornerRadii: .init(topLeading: 24, topTrailing: 24)))
    }
}

extension OnboardingSheet {
    func handleNextButtonPressed() {
        // GO TO NEXT SECTION
        if onboardingState == 5 {
            signIn()
        } else {
            withAnimation {
                onboardingState += 1
            }
        }
    }
    
    func signIn() {
        withAnimation {
            vm.currentUserSignedIn = true
        }
    }
}
