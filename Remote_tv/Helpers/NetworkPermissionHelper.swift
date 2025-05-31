//
//  NetworkPermissionHelper.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 30.05.2025.
//
import Foundation
import Network

class NetworkPermissionHelper: NSObject {
    static let shared = NetworkPermissionHelper()
    
    func requestLocalNetworkPermission() {
        
        let browser = NWBrowser(for: .bonjour(type: "_http._tcp", domain: nil), using: .udp)
        
        browser.stateUpdateHandler = { state in
            switch state {
            case .ready:
                print("Браузер готов к работе")
            case .failed(let error):
                print("Ошибка браузера: \(error)")
            default:
                break
            }
        }
        
        browser.start(queue: .main)
    }
}

