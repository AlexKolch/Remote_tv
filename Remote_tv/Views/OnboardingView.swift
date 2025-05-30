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

struct OnboardingSheet: View {
    @EnvironmentObject var vm: IntroViewModel
    @State var isPaywall = false
    @Binding var toggleIsOn: Bool
    @Binding var onboardingState: Int
    
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 24.0) {
            VStack(alignment: .center, spacing: 16.0) {
                AttributedText(text: title, fontSize: 28, fontWeight: .bold, lineHeightPercent: 100)
                    .frame(width: 343, height: 34)
//                Text(title)
//                    .fontWithLineHeight(font: .inter, fontSize: 28, letterSpacing: 0.02, lineHeight: 34)
//                    .bold()
//                    .foregroundStyle(.white)
                
                AttributedText(text: description)
                    .frame(width: 343, height: 46)
              
//                Text(description)
//                    .font(FontBuilder.description.font)
//                    .tracking(FontBuilder.description.tracking)
//                    .lineSpacing(1.4)
//                    .foregroundStyle(.white)
//                    .multilineTextAlignment(.center)
                
                if onboardingState == 3 {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.bglevel2)
                                .frame(maxWidth: .infinity)
                                .frame(height: 63)
                            
                            HStack {
                                Toggle(isOn: $toggleIsOn) {
                                    if toggleIsOn {
                                        AttributedText(text: "3-day free trial enabled")
                                            .frame(height: 24)
//                                        Text("3-day free trial enabled")
//                                            .fontWithLineHeight(font: .inter, fontSize: 16, letterSpacing: 0.02, lineHeight: 24)
//                                            .foregroundStyle(.white)
                                    } else {
                                        VStack(alignment: .leading, spacing: 0) {
                                            AttributedText(text: "Not sure yet?", alignment: .left)
                                                .frame(height: 22)
//                                            Text("Not sure yet?")
//                                                .fontWithLineHeight(font: .inter, fontSize: 16, letterSpacing: 0.02, lineHeight: 22)
//                                                .foregroundStyle(.white)
                                            AttributedText(text: "Enable a 3-day free trial", fontSize: 12, alignment: .left)
                                                .frame(height: 17)
//                                            Text("Enable a 3-day free trial")
//                                                .fontWithLineHeight(font: .inter, fontSize: 12, letterSpacing: 0.02, lineHeight: 17)
//                                                .foregroundStyle(.white.opacity(0.6))
                                            
                                        }
                                        .padding(.vertical, 12)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 39)
                                    }
                                }
                                .tint(.accentColor)
                                .toggleStyle(GradientToggleStyle())
//                                .tint(LinearGradient.addLinerGradient(startPoint: .leading, endPoint: .trailing))
                                .padding(.trailing, 12)
                                .padding(.leading, 16)
                                
                            }
                        }
               
                }
            }


            if isPaywall {
                Image(.loader)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
                    .onAppear {
                        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                            vm.startPayment()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                isPaywall = false
                            }
                        }
                    }
            } else {
                Button {
                    if onboardingState == 3 {
                        isPaywall.toggle()
                    } else {
                        handleNextButtonPressed()
                    }
                } label: {
                    Text(toggleIsOn ? "Try free" : "Continue")
                        .foregroundColor(.white)
                        .font(.inter, size: 18).bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .background(LinearGradient.addLinerGradient(startPoint: .leading, endPoint: .trailing))
                        .clipShape(.rect(cornerRadius: 12))
                }
            }
         
            
            HStack() {
                Group {
                    Link("Privacy Policy",
                         destination: URL(string: "https://docs.google.com/document/d/1wY6VO-Xg6DStAav4ywjC236OuebpvqHqjIliZdMz9LE/edit?usp=sharing")!)
                    Text("Restore")
//                        .tracking(FontBuilder.infoBtn.tracking)
                    Link("Terms of Service",
                         destination: URL(string: "https://docs.google.com/document/d/1HOGEoKmiRYtQK_7kFne9oKCUmijPSSbhrYnzS1hzsAo/edit?usp=sharing")!)
                }
                .font(FontBuilder.infoBtn.font)
                .lineSpacing(FontBuilder.infoBtn.lineSpacing)
                .padding(.vertical, FontBuilder.infoBtn.verticalPadding)
                .frame(height: 40)
                .frame(minWidth: 98.33, alignment: .center)
                .padding(.horizontal, 8)
                .padding(.vertical, 11.5)
                .foregroundStyle(.white.opacity(0.6))
            }
            
        }
        .frame(height: onboardingState < 3 ? 279 : 358)
        .padding(.top, 32)
        .padding([.horizontal, .bottom], 16)
        .background(Color.bglevel1)
        .cornerRadius(24, corners: [.topLeft, .topRight])
//        .clipShape(.rect(cornerRadii: .init(topLeading: 24, topTrailing: 24)))
        .overlay(alignment: .top) {
            if onboardingState == 3 {
                blurView
                    .offset(y: -70)
                    .padding(.horizontal, 16)
            }
        }
    }
}

extension OnboardingSheet {
    
   private var blurView: some View {
       ZStack {
           Rectangle()
               .fill(Color.white.opacity(0.1))
               .frame(height: 68)
               .background(
                GlassView(removeEffects: true)
                    .blur(radius: 20, opaque: true)
               )
               .cornerRadius(12)

           HStack(spacing: 12.0) {
               Image(.premium)
                   .resizable()
                   .frame(width: 24, height: 24)
                 
               AttributedText(text: "Access to sleep timer, touchpad and multimedia controller")
                   .frame(width: 275, height: 49)
//               Text("Access to sleep timer, touchpad and multimedia controller")
//                   .frame(width: 275)
//                   .font(FontBuilder.description.font)
//                   .tracking(FontBuilder.description.tracking)
//                   .lineSpacing(1.4)
//                   .environment(\._lineHeightMultiple, 1.4) //РАЗОБРАТЬСЯ С ТВ!!!!!!!!!!!!!!!!!!!!
//                   .foregroundStyle(.white)
//                   .multilineTextAlignment(.center)
                   
           }
           .frame(maxWidth: .infinity)
           .padding(.horizontal, 16)
       }
   }
    
    
    func handleNextButtonPressed() {
        // GO TO NEXT SECTION
        if onboardingState == 4 {
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
