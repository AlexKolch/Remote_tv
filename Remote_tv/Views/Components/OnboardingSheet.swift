//
//  OnboardingSheet.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 31.05.2025.
//

import SwiftUI

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
                
                AttributedText(text: description)
                    .frame(width: 343, height: 46)
                
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
                                    } else {
                                        VStack(alignment: .leading, spacing: 0) {
                                            AttributedText(text: "Not sure yet?", alignment: .left)
                                                .frame(height: 22)

                                            AttributedText(text: "Enable a 3-day free trial", fontSize: 12, alignment: .left)
                                                .frame(height: 17)
                                        }
                                        .padding(.vertical, 12)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .frame(height: 39)
                                    }
                                }
                                .tint(.accentColor)
                                .toggleStyle(GradientToggleStyle())
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


#Preview {
    OnboardingSheet(toggleIsOn: .constant(false), onboardingState: .constant(0), title: "Smart TV control", description: "Easiest way to control your smart TV with your phone")
}
