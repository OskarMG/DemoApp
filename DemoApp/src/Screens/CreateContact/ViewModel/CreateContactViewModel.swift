//
//  CreateContactViewModel.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import Foundation
import UIKit.UIResponder

final class CreateContactViewModel: CreateContactViewModeling {
    
    @Published var name: String = ""
    @Published var lastName: String = ""
    @Published var phone: String = ""
    @Published var selectedAvatar: String?
    @Published var isGalleryVisible: Bool = false
    
    var canSaveContact: Bool {
        name.isNotEmptyOrWhitespace &&
        lastName.isNotEmptyOrWhitespace &&
        phone.isNotEmptyOrWhitespace
    }
    
    /// `Events`
    func onEditProfilePicture() {
        dismissKeyboard()
        print("onEditProfilePicture")
    }
    
    func onSaveContact() {
        dismissKeyboard()
        let newContact = Contact(name: name, lastName: lastName, phone: phone)
        print("newContact: \(newContact)")
    }
    
    func dismissKeyboard() {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
}
