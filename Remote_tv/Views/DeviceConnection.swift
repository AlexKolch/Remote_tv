//
//  DeviceConnection.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 29.05.2025.
//

import SwiftUI

struct DeviceConnection: View {
    @StateObject var viewModel: DeviceConnectionVM = .init()
    @State var degree: Double = 0.0
    
    var body: some View {
        VStack(spacing: 8.0) {
            HStack {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 12.73, height: 12.73)
                    .padding(5.64)
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding(16)
                
                
                AttributedText(text: "Device detection", foregroundColor: .white)
                    .frame(maxWidth: .infinity)
                Rectangle()
                    .frame(width: 56, height: 56)
                    .hidden()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            
            VStack(alignment: .center, spacing: 16.0) {
                AttributedText(text: "Searching for devices", foregroundColor: .white.withAlphaComponent(0.6))
                    .frame(maxWidth: .infinity)
                    .frame(height: 22)
                
                if viewModel.devices.isEmpty {
                    Spacer()
                    Image(.loader)
                        .resizable()
                        .frame(width: 48, height: 48)
                        .rotationEffect(.degrees(degree))
                        .onAppear {
                            withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                                degree += 360
                            }
                        }
                    Spacer()
                } else {
                    VStack(spacing: 12.0) {
                        ForEach(viewModel.devices, id: \.self) { device in
                            DeviceCard(name: device)
                                .clipShape(.rect(cornerRadius: 12))
                            
                        }
                        
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                
                AttributedText(text: "Smart TV and your device must be connected to the same Wi-Fi network", fontWeight: .regular, foregroundColor: .white.withAlphaComponent(0.6), lineHeightPercent: 140, letterSpacingPercent: 2)
                    .frame(width: 343, height: 46)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.bglevel1)
    }
}

#Preview {
    DeviceConnection()
}
