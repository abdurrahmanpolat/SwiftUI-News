//
//  UITextViewWrapper.swift
//  IntegrationApp
//
//  Created by Abdurrahman Polat on 25.06.2025.
//

import SwiftUI
import UIKit

// MARK: - 1. UIKit View'ları SwiftUI'de Kullanma (UIViewRepresentable)

// Özel UIKit TextView'ını SwiftUI'de kullanma
struct UITextViewWrapper: UIViewRepresentable {
    @Binding var text: String
    @State private var textViewHeight: CGFloat = 100
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = UIColor.systemBackground
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.isScrollEnabled = true
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        let parent: UITextViewWrapper
        
        init(_ parent: UITextViewWrapper) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == "Buraya yazın..." {
                textView.text = ""
                textView.textColor = UIColor.label
            }
        }
    }
}
