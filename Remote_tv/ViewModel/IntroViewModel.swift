//
//  ViewModel.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 26.05.2025.
//

import Foundation
import SwiftUI
import StoreKit

final class IntroViewModel: ObservableObject {
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @Published var isLoading: Bool = false
    
    @MainActor func requestAppReview() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            AppStore.requestReview(in: windowScene)
        } else {
            //Сделать в будущем. Если не получилось – открываем App Store
        }
    }
    
    func startPayment() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let result = Bool.random()
            if result {
                self.currentUserSignedIn = true
                print("Success purchasing!")
            } else {
                print("Purchasing was failed, try again")
            }
            self.isLoading = false
        }
    }
}
