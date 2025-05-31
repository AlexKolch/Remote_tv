//
//  DeviceConnectionVM.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 29.05.2025.
//
import AVFoundation
import SwiftUI

final class DeviceConnectionVM: ObservableObject {
    
    enum Status: String {
        case searching = "Searching for devices"
        case selecting = "Select the device for connection"
        case connection = "Connecting your device"
        case connected = "Device connected"
        case failure = "Couldn’t find your devices"
    }
    
    let userDefaults = UserDefaults.standard
    @Published var devices: [Device] = []
    @Published var status: Status = .searching
    
    init() {
        loadDevices()
    }

    
    private func loadDevices() {
        if let devicesData = userDefaults.data(forKey: "devices") {
            do {
                let decoder = JSONDecoder()
                let fetchedDevices = try decoder.decode([Device].self, from: devicesData)
                self.devices = fetchedDevices
            } catch {
                print("Fetching devices failed: \(error)")
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                self?.devices.append(contentsOf: [
                    Device(name: "Smart LG TV"),
                    Device(name: "LG UHD UF")
                ])
                
                do {
                    let encoder = JSONEncoder()
                    let deviceData = try encoder.encode(self?.devices)
                    self?.userDefaults.setValue(deviceData, forKey: "devices")
                } catch {
                    print("Saving devices failed: \(error)")
                }
            }
        }
    }
    
}
