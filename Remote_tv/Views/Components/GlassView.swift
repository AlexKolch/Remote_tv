//
//  GlassView.swift
//  Remote_tv
//
//  Created by Алексей Колыченков on 27.05.2025.
//

import SwiftUI

struct GlassView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemUltraThinMaterial
    var removeEffects = false
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            if let subLayer = uiView.layer.sublayers?.first {
                if self.removeEffects {
                    subLayer.filters?.removeAll()
                } else {
                    subLayer.filters?.removeAll { filter in
                        String(describing: filter) != "gaussianBlur" //удаляет все кроме gaussianBlur
                    }
                }
            }
        }
    }
}
