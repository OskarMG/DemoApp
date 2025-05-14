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
    private weak var contactDelegate: ContactDelegate?
    private weak var wrapperDelegate: CreateContactWrapperDelegate?
    
    var canSaveContact: Bool {
        name.isNotEmptyOrWhitespace &&
        lastName.isNotEmptyOrWhitespace &&
        phone.isNotEmptyOrWhitespace
    }
    
    init(
        contactDelegate: ContactDelegate?,
        wrapperDelegate: CreateContactWrapperDelegate?,
        repository: CreateContactAPIRepositoring = CreateContactAPIRepository()
    ) {
        self.repository = repository
        self.contactDelegate = contactDelegate
        self.wrapperDelegate = wrapperDelegate
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
        contactDelegate?.didSave(contact: .init(
            name: name,
            lastName: lastName,
            phone: phone)
        )
        wrapperDelegate?.didDismiss()
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
