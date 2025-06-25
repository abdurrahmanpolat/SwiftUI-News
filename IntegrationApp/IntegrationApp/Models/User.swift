//
//  User.swift
//  IntegrationApp
//
//  Created by Abdurrahman Polat on 25.06.2025.
//

import Foundation

// MARK: - 4. Veri Modeli
struct User {
    let id: UUID
    let name: String
    let email: String
    let bio: String
    let avatarURL: String
    
    static let sample = User(
        id: UUID(),
        name: "Abdurrahman Polat",
        email: "abdurrahmanpolat1453@gmail.com",
        bio: "iOS Developer ve SwiftUI meraklısı. Açık kaynak projelere katkıda bulunmayı seviyorum.",
        avatarURL: "https://static.vecteezy.com/system/resources/thumbnails/036/594/092/small/man-empty-avatar-photo-placeholder-for-social-networks-resumes-forums-and-dating-sites-male-and-female-no-photo-images-for-unfilled-user-profile-free-vector.jpg"
    )
}
