//
//  CustomFonts.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 25.05.2025.
//

import SwiftUI

extension Font {
    static func custom(_ customFonts: CustomFonts, size: CGFloat) -> Font {
        Font.custom(customFonts.rawValue, fixedSize: size)
    }
}

extension Text {
    func font(_ customFonts: CustomFonts = .inter, size: CGFloat) -> Text {
        self.font(Font.custom(customFonts, size: size))
    }
}

struct FontBuilder {
    let font: Font
    let tracking: Double //Letter spacing
    let lineSpacing: Double
    let verticalPadding: Double //для однострочных текстов
    
    init(customFont: CustomFonts, fontSize: Double, letterSpacing: Double, lineHeight: Double) {
        self.font = Font.custom(customFont, size: fontSize)
        self.tracking = fontSize * letterSpacing
        
        let uiFont = UIFont(name: customFont.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
        self.lineSpacing = lineHeight - uiFont.lineHeight
        self.verticalPadding = lineSpacing / 2
    }
}

extension FontBuilder {
    static let title = FontBuilder(customFont: .inter, fontSize: 28, letterSpacing: 0.02, lineHeight: 34)
    
    static let description = FontBuilder(customFont: .inter, fontSize: 16, letterSpacing: 0.02, lineHeight: 44)
    
    static let infoBtn = FontBuilder(customFont: .inter, fontSize: 12, letterSpacing: 0.02, lineHeight: 17)
}



@available(iOS 16.0, *)
struct FontWithLineHeight: ViewModifier {
    let font: CustomFonts
    let fontSize: Double
    let letterSpacing: Double
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        let uiFont = UIFont(name: font.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
        content
            .font(Font(uiFont))
            .kerning(fontSize * letterSpacing)
            .lineSpacing(lineHeight - uiFont.lineHeight)
            .padding(.vertical, (lineHeight - uiFont.lineHeight) / 2)
    }
}

@available(iOS 16.0, *)
extension View {
    func fontWithLineHeight(font: CustomFonts = .inter, fontSize: Double, letterSpacing: Double, lineHeight: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: FontWithLineHeight(font: font, fontSize: fontSize, letterSpacing: letterSpacing, lineHeight: lineHeight))
    }
}


