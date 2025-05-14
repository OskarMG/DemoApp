//
//  CreateContactViewModel.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import Foundation
import UIKit.UIResponder

final class CreateContactViewModel: @preconcurrency CreateContactViewModeling {
    @Published var name: String = ""
    @Published var lastName: String = ""
    @Published var phone: String = ""
    @Published var selectedAvatar: Picture?
    @Published var isGalleryVisible: Bool = false
    @Published var photoCollection: PictureResponse = []
    
    private let repository: CreateContactAPIRepositoring
    
    var canSaveContact: Bool {
        name.isNotEmptyOrWhitespace &&
        lastName.isNotEmptyOrWhitespace &&
        phone.isNotEmptyOrWhitespace
    }
    
    init(
        repository: CreateContactAPIRepositoring = CreateContactAPIRepository()
    ) {
        self.repository = repository
    }
    
    private func showGallery() {
        isGalleryVisible = true
    }
    
    /// `Events`
    @MainActor
    func onViewAppear() { getCollection() }
    
    func didSelect(photo: Picture) {
        selectedAvatar = photo
        isGalleryVisible = false
    }

    func onSaveContact() {
        dismissKeyboard()
        let _ = Contact(name: name, lastName: lastName, phone: phone)
        // TODO: PASS DATA TO THE LIST
    }
    
    func dismissKeyboard() {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    @MainActor
    func onEditProfilePicture() {
        dismissKeyboard()
        showGallery()
        guard photoCollection.isEmpty else { return }
        getCollection()
    }
    
    @MainActor
    private func getCollection() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let collection = try await self.repository.getPictureCollection()
                self.photoCollection = collection
            } catch {
                /// Handle Error || Ask UX Team
                /// `debugPrint("@Error: \(error)")
            }
        }
    }

}
