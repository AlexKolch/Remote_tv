//
//  AttributedText.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 30.05.2025.
//

import SwiftUI

enum CustomFonts: String {
    case inter = "Inter"
    case regular = "Inter-Regular"
    case bold = "Inter-Bold"
}

struct AttributedText: UIViewRepresentable {
    let text: String
    var fontSize: CGFloat = 16.0
    var fontWeight: CustomFonts = .regular
    var foregroundColor: UIColor = .white
    
    // Параметры из Figma
    var lineHeightPercent: CGFloat = 140  // Например 140 (%)
    var letterSpacingPercent: CGFloat = 2 // Например 2 (%)
    var alignment: NSTextAlignment = .center
    
    private var absoluteLineHeight: CGFloat {
        return fontSize * lineHeightPercent / 100
    }
    
    private var absoluteLetterSpacing: CGFloat {
        return fontSize * letterSpacingPercent / 100
    }
    
    // Рассчитываем lineSpacing (разница между lineHeight и fontSize)
    private var lineSpacing: CGFloat {
        return absoluteLineHeight - fontSize
    }
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        let font = UIFont.defaultFont(fontWeight, size: fontSize)
        
        // Создаем параграф с нужным межстрочным интервалом
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        
        // Создаем атрибутированную строку
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .font: font,
                .foregroundColor: foregroundColor,
                .kern: absoluteLetterSpacing,
                .paragraphStyle: paragraphStyle
            ]
        )
        uiView.attributedText = attributedString
    }
}

