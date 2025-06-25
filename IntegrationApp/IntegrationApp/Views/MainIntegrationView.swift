//
//  MainIntegrationView.swift
//  IntegrationApp
//
//  Created by Abdurrahman Polat on 25.06.2025.
//

import SwiftUI

// MARK: - 5. Ana SwiftUI View - Tüm Entegrasyonları Gösteren

struct MainIntegrationView: View {
    @State private var textContent = "Buraya yazın..."
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    @State private var showUIKitView = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    
                    // UIKit TextView Entegrasyonu
                    VStack(alignment: .leading, spacing: 10) {
                        Text("UIKit TextView Entegrasyonu")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                        
                        UITextViewWrapper(text: $textContent)
                            .frame(height: 120)
                            .padding(.horizontal)
                    }
                    
                    Divider()
                    
                    // Image Picker Entegrasyonu
                    VStack(spacing: 15) {
                        Text("UIKit Image Picker")
                            .font(.headline)
                        
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 200)
                                .cornerRadius(10)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 200)
                                .cornerRadius(10)
                                .overlay(
                                    VStack {
                                        Image(systemName: "photo")
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                        Text("Resim Seçilmedi")
                                            .foregroundColor(.gray)
                                    }
                                )
                        }
                        
                        Button("Resim Seç") {
                            showImagePicker = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // SwiftUI in UIKit Demo
                    VStack(spacing: 15) {
                        Text("SwiftUI View in UIKit")
                            .font(.headline)
                        
                        // SwiftUI Profile View
                        SwiftUIProfileView(user: User.sample)
                            .frame(maxHeight: 400)
                            .background(Color(.systemBackground))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // Hibrit Yaklaşım Demo
                    VStack(spacing: 15) {
                        Text("Hibrit Yaklaşım")
                            .font(.headline)
                        
                        Text("Bu uygulama SwiftUI ana yapısı ile UIKit bileşenlerini harmanlıyor")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button("UIKit View Controller Aç") {
                            showUIKitView = true
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("SwiftUI ↔ UIKit")
            .sheet(isPresented: $showImagePicker) {
                ImagePickerWrapper(selectedImage: $selectedImage, isPresented: $showImagePicker)
            }
            .sheet(isPresented: $showUIKitView) {
                UIKitViewControllerWrapper()
            }
        }
    }
}
