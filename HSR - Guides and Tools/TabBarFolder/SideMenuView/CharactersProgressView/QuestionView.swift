//
//  QuestionView.swift
//  HSR - Guides and Tools
//
//  Created by Денис on 29.10.2023.
//

import SwiftUI

struct QuestionView: View {
    @Binding var showQuestionView: Bool
    
    
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .systemMaterial, alpha: 0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Информация")
                    .padding()
                
                Button("Понятно") {
                    self.showQuestionView = false
                }
            }
            .frame(width: 300, height: 200)
            .background(Color.gray)
            .cornerRadius(20)
        }
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    var alpha: CGFloat
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        view.alpha = alpha
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = UIBlurEffect(style: blurStyle)
        uiView.alpha = alpha
    }
}

