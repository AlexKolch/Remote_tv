//
//  ViewModel.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 26.05.2025.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
}
