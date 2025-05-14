//
//  CreateContactViewModeling.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import Combine

protocol CreateContactViewModeling: AnyObject, ObservableObject {
    var name: String { get set}
    var lastName: String { get set}
    var phone: String { get set}
    var canSaveContact: Bool { get }
    var selectedAvatar: Picture? { get }
    var isGalleryVisible: Bool { get set }
    var photoCollection: PictureResponse { get }
    /// `Methods`
    func onViewAppear()
    func onSaveContact()
    func dismissKeyboard()
    func onEditProfilePicture()
    func didSelect(photo: Picture)
}
