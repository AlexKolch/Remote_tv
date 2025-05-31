//
//  DeviceConnection.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 29.05.2025.
//

import SwiftUI
enum StateScreen: String {
    case searching, selecting, connection, connected, failure
}

struct DeviceConnection: View {
    @StateObject var viewModel: DeviceConnectionVM = .init()
    @State var degree: Double = 0.0
    @State private var currentStateScreen: StateScreen = .searching
    @State private var selectedDevice: Device? = nil
    @State private var isSelect: Bool = false
    
    
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
                AttributedText(text: textFor(state: currentStateScreen), foregroundColor: .white.withAlphaComponent(0.6))
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
                        ForEach(viewModel.devices) { device in
                            DeviceCard(device: device)
                                .clipShape(.rect(cornerRadius: 12))
                                .onTapGesture {
                                    print(device)
                                    
                                    //                                    updated(at: device)
                                    self.isSelect = true
                                    currentStateScreen = nextState(after: currentStateScreen)
                                }
                        }
                        
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .onAppear {
                        currentStateScreen = nextState(after: currentStateScreen)
                    }
                }
                
                AttributedText(text: "Smart TV and your device must be connected to the same Wi-Fi network", fontWeight: .inter, foregroundColor: .white.withAlphaComponent(0.6), lineHeightPercent: 140, letterSpacingPercent: 2)
                    .frame(width: 343, height: 46)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.bglevel1)
        .onAppear {
            NetworkPermissionHelper.shared.requestLocalNetworkPermission()
        }
    }
}

#Preview {
    DeviceConnection()
}

extension DeviceConnection {
    
    func textFor(state: StateScreen) -> String {
        switch state {
        case .searching:
            return "Searching for devices"
        case .selecting:
            return "Select the device for connection"
        case .connection:
            return "Connecting your device"
        case .connected:
            return "Device connected"
        case .failure:
            return "Couldn’t find your devices"
        }
    }
    
    func nextState(after state: StateScreen) -> StateScreen {
        switch state {
        case .searching:
            return .selecting
        case .selecting:
            return .connection
        case .connection:
            return .connected
        case .connected:
            return .connected
        case .failure:
            return .searching
        }
    }
}
