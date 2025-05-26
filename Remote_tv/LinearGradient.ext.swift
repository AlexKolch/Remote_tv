//
//  LinearGradient.ext.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 25.05.2025.
//

import SwiftUI

extension LinearGradient {
    
    static func addLinerGradient(startPoint: UnitPoint = .top, endPoint: UnitPoint = .bottom) -> LinearGradient {
        LinearGradient(colors: [.primaryFirst, .primarySecond], startPoint: startPoint, endPoint: endPoint)
    }
    
}

