//
//  DeviceCard.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 29.05.2025.
//
import SwiftUI


struct DeviceCard: View {
    enum StateCard {
        case selecting, connection, connected
    }
    
    let device: Device
    var isSelect: Bool = false
    @State private var currentState: StateCard = .selecting
    
    var body: some View {
        HStack(spacing: 12.0) {
            VStack(alignment: .leading, spacing: 4) {
                AttributedText(text: device.description, fontSize: 12, foregroundColor: .white.withAlphaComponent(0.6), alignment: .left)
                    .frame(maxWidth: .infinity)
                    .frame(height: 17)

                AttributedText(text: device.name, alignment: .left)
                    .frame(maxWidth: .infinity)
                    .frame(height: 22)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
                        
          
            if isSelect {
                GetIconFor(state: currentState)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.white)
    
            } else {
                Image(systemName: "chevron.right")
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.white)
            }

        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14.5)
        .background(Color.bglevel2)
  
    }
}


extension DeviceCard {
    
   @ViewBuilder
   private func GetIconFor(state: StateCard) -> some View {
        switch state {
        case .selecting:
           Image(systemName: "chevron.right")
        case .connection:
            Image(.connectionLoader)
        case .connected:
           Image(systemName: "checkmark")
        }
       
    }
}

#Preview {
    DeviceCard(device: Device(name: "Smart LG TV"))
        .background(Color.bglevel2)
}
