//
//  Device.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 31.05.2025.
//

import Foundation

struct Device: Codable, Identifiable {
    var id = UUID().uuidString
    let name: String
    var description = "Device"
    var isSelected: Bool = false
}
