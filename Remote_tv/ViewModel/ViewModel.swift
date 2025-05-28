//
//  ViewModel.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 26.05.2025.
//

import Foundation
import SwiftUI
import StoreKit

final class ViewModel: ObservableObject {
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
    }
}
