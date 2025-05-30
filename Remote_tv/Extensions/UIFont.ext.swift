//
//  UIFont.ext.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 30.05.2025.
//

import UIKit

extension UIFont {
    static func defaultFont(_ style: CustomFonts, size: CGFloat) -> UIFont {
      
        return UIFont(name: style.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}


