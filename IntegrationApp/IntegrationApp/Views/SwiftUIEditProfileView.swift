//
//  SwiftUIEditProfileView.swift
//  IntegrationApp
//
//  Created by Abdurrahman Polat on 25.06.2025.
//

import SwiftUI

struct SwiftUIEditProfileView: View {
    let user: User
    @State private var name: String
    @State private var bio: String
    @Environment(\.dismiss) private var dismiss
    
    init(user: User) {
        self.user = user
        self._name = State(initialValue: user.name)
        self._bio = State(initialValue: user.bio)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Kişisel Bilgiler") {
                    TextField("Ad Soyad", text: $name)
                    TextField("Biyografi", text: $bio, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Profili Düzenle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
                        // Kaydetme işlemi
                        dismiss()
                    }
                }
            }
        }
    }
}

