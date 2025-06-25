//
//  SwiftUIProfileView.swift
//  IntegrationApp
//
//  Created by Abdurrahman Polat on 25.06.2025.
//

import SwiftUI

// MARK: - 3. SwiftUI View'ları UIKit'te Kullanma (UIHostingController)

struct SwiftUIProfileView: View {
    let user: User
    @State private var isEditing = false
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: user.avatarURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            
            VStack(spacing: 8) {
                Text(user.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(user.bio)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Button(action: {
                isEditing = true
            }) {
                Text("Profili Düzenle")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isEditing) {
            SwiftUIEditProfileView(user: user)
        }
    }
}
