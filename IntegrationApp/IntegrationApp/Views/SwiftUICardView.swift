//
//  SwiftUICardView.swift
//  IntegrationApp
//
//  Created by Abdurrahman Polat on 25.06.2025.
//

import SwiftUI

struct SwiftUICardView: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("SwiftUI Card in UIKit")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Bu SwiftUI view'ı UIKit View Controller içinde çalışıyor")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button(action: {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
            }) {
                Text(isExpanded ? "Küçült" : "Genişlet")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            if isExpanded {
                VStack(spacing: 10) {
                    ForEach(1...3, id: \.self) { index in
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("Özellik \(index)")
                                .font(.subheadline)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                .transition(.opacity.combined(with: .slide))
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}
