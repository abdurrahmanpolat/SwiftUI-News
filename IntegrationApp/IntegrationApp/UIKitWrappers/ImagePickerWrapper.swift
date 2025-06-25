//
//  ImagePickerWrapper.swift
//  IntegrationApp
//
//  Created by Abdurrahman Polat on 25.06.2025.
//

import SwiftUI
import UIKit

// MARK: - Image Picker Wrapper

/*
 Bu struct, UIKit'in UIImagePickerController'ını SwiftUI'de kullanmamızı sağlar.
 UIViewControllerRepresentable protokolü sayesinde UIKit view controller'larını
 SwiftUI view'ları gibi kullanabiliriz.
*/
struct ImagePickerWrapper: UIViewControllerRepresentable {
    
    // MARK: - Properties
    /*
     @Binding: SwiftUI'de iki yönlü veri bağlama için kullanılır
     Parent view'dan gelen değerleri değiştirebilir ve değişiklikleri geri bildirebilir
    */
    @Binding var selectedImage: UIImage?  // Seçilen resmi parent view'a aktarır
    @Binding var isPresented: Bool        // Modal'ın açık/kapalı durumunu kontrol eder
    
    // MARK: - UIViewControllerRepresentable Protocol Methods
    /*
     makeUIViewController: UIKit view controller'ını oluşturur
     Bu method yalnızca bir kez çağrılır (view ilk oluşturulduğunda)
    */
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        // Delegate pattern: UIKit'in callback mekanizması
        // context.coordinator, bizim oluşturduğumuz Coordinator sınıfının instance'ı
        picker.delegate = context.coordinator
        
        // Resim kaynağı: fotoğraf kütüphanesi
        picker.sourceType = .photoLibrary
        
        // Kullanıcının resmi crop etmesine izin ver
        picker.allowsEditing = true
        
        return picker
    }
    
    /*
     updateUIViewController: View güncellendiğinde çağrılır
     Bu örnekte güncelleme yapmıyoruz çünkü picker static
    */
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Boş bıraktık çünkü runtime'da picker'ı güncellememiz gerekmiyor
    }
    
    /*
     makeCoordinator: Coordinator instance'ını oluşturur
     Coordinator, UIKit'in delegate pattern'ını SwiftUI'ye bağlayan köprü
    */
    func makeCoordinator() -> Coordinator {
        Coordinator(self) // Self referansı ile parent'a erişim sağlar
    }
    
    // MARK: - Coordinator Class
    
    /*
     Coordinator sınıfı:
     - NSObject'ten inherit eder (Objective-C runtime için gerekli)
     - UIImagePickerControllerDelegate: resim seçimi olaylarını yakalar
     - UINavigationControllerDelegate: navigation olaylarını yakalar
    */
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePickerWrapper // Parent view'a referans
        
        init(_ parent: ImagePickerWrapper) {
            self.parent = parent
        }
        
        /*
         imagePickerController didFinishPickingMediaWithInfo:
         Kullanıcı resim seçtiğinde çağrılır
        */
        func imagePickerController(_ picker: UIImagePickerController,
                                 didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            /*
             info dictionary'si seçilen medya hakkında bilgi içerir:
             - .editedImage: Kullanıcının crop ettiği resim
             - .originalImage: Orijinal resim
             - .imageURL: Resmin dosya URL'i
             - .mediaType: Medya tipi (resim, video, vb.)
            */
            
            // Önce edited image'ı kontrol et, yoksa original'ı al
            if let editedImage = info[.editedImage] as? UIImage {
                parent.selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.selectedImage = originalImage
            }
            
            // Modal'ı kapat
            parent.isPresented = false
        }
        
        /*
         imagePickerControllerDidCancel:
         Kullanıcı "İptal" butonuna bastığında çağrılır
        */
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false // Modal'ı kapat
        }
    }
}
