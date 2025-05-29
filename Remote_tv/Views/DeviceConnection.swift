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
//                    .background(.gray)
                
                Text("Device detection")
                    .foregroundStyle(.white)
                    .fontWithLineHeight(fontSize: 16, letterSpacing: 0.02, lineHeight: 22)
                    .frame(maxWidth: 263)
//                    .background(.gray)
                
                Rectangle()
                    .frame(width: 56, height: 56)
                    .hidden()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
//            .background(.white)
            
            VStack(alignment: .center) {
                Text("Searching for devices")
                    .foregroundStyle(.white.opacity(0.6))
                    .fontWithLineHeight(fontSize: 16, letterSpacing: 0.02, lineHeight: 22)
                    .frame(maxWidth: .infinity)
//                    .background(.gray)

                   Spacer()
                if viewModel.devices.isEmpty {
                    Image(.loader)
                        .resizable()
                        .frame(width: 48, height: 48)
                        .rotationEffect(.degrees(degree))
                        .onAppear {
                            withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                                degree += 360
                            }
                        }
                } else {
                    VStack {
                        ForEach(viewModel.devices, id: \.self) { device in
                            Text(device)
                                .foregroundStyle(.white)
                        }
                    }
                }
                
                Spacer()
                Text("Smart TV and your device must be connected to the same Wi-Fi network")
                    .foregroundStyle(.white.opacity(0.6))
                    .font(FontBuilder.description.font)
                    .tracking(FontBuilder.description.tracking)
                    .lineSpacing(1.4)
                    .multilineTextAlignment(.center)
                    .frame(width: 343)
//                    .background(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
//            .background(.yellow)
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.bglevel1)
//        .onAppear {
//            viewModel.
//        }
    }
}

#Preview {
    DeviceConnection()
}
