//
//  GradientToggleStyle.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 30.05.2025.
//

import SwiftUI

struct GradientToggleStyle: ToggleStyle {
    let gradient = LinearGradient(
        colors: [.primaryFirst, .primarySecond],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    let gradientOff = LinearGradient(
        colors: [.bglevel1],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    func makeBody(configuration: Configuration) -> some View {
         HStack {
             configuration.label
             Spacer()
             RoundedRectangle(cornerRadius: 16)
                 .fill(configuration.isOn ? gradient : gradientOff)
                 .frame(width: 50, height: 30)
                 .overlay(
                     Circle()
                         .fill(.white)
                         .padding(3)
                         .offset(x: configuration.isOn ? 10 : -10)
                 )
                 .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                 .onTapGesture {
                     configuration.isOn.toggle()
                 }
         }
     }
}
