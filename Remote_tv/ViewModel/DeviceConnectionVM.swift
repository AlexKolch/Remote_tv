//
//  DeviceConnectionVM.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 29.05.2025.
//

import SwiftUI

final class DeviceConnectionVM: ObservableObject {
    
    let userDefaults = UserDefaults.standard
   @Published var devices: [String] = []
    
    init() {
        loadDevices()
    }
    
   private func loadDevices() {
       if let fetchedDevices = userDefaults.stringArray(forKey: "devices") {
           devices = fetchedDevices
       } else {
           DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
               self.devices.append(contentsOf: [
                "Smart LG TV",
                "LG UHD UF",
               ])
               DispatchQueue.global().async {
                   self.userDefaults.set(self.devices, forKey: "devices")
               }
           }
       }
    }
    
}
