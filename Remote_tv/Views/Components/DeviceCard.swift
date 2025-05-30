//
//  DeviceCard.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 29.05.2025.
//

import SwiftUI

struct DeviceCard: View {
    let description: String = "Device"
    let name: String
    
    var body: some View {
        HStack(spacing: 12.0) {
            VStack(alignment: .leading, spacing: 4) {
                AttributedText(text: description, fontSize: 12, foregroundColor: .white.withAlphaComponent(0.6), alignment: .left)
                    .frame(maxWidth: .infinity)
                    .frame(height: 17)
//                    .background(Color.red)
//                Text(description)
//                    .fontWithLineHeight(fontSize: 12, letterSpacing: 0.002, lineHeight: 17)
//                    .foregroundStyle(.white.opacity(0.6))
                AttributedText(text: name, alignment: .left)
                    .frame(maxWidth: .infinity)
                    .frame(height: 22)
                 
//                Text(name)
//                    .fontWithLineHeight(fontSize: 16, letterSpacing: 0.002, lineHeight: 22)
//                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "chevron.right")
                .frame(width: 24, height: 24)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14.5)
        .background(Color.bglevel2)
  
    }
}

#Preview {
    DeviceCard(name: "Smart LG TV")
        .background(Color.bglevel2)
}
