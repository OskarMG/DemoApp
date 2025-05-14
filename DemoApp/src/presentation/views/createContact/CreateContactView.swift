//
//  CreateContactView.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import SwiftUI

struct CreateContactView<ViewModel>: View where ViewModel: CreateContactViewModeling {
    @StateObject private var viewModel: ViewModel

    init(viewModel: @autoclosure @escaping () -> ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: .padding16) {
                Button(action: viewModel.onEditProfilePicture) {
                    ProfileView(
                        url: viewModel.selectedAvatar?.url,
                        width: .profileWidth,
                        height: .profileHeight
                    )
                }
                .overlay(alignment: .bottomTrailing, content: setupEditIcon)
                
                FormInput(input: $viewModel.name, placeHolder: Strings.nameLabel)
                FormInput(input: $viewModel.lastName, placeHolder: Strings.lastNameLabel)
                FormInput(input: $viewModel.phone, placeHolder: Strings.phoneLabel, keyboardType: .phonePad)
                
                saveButton
            }
            .padding(.top, .padding16)
            .padding(.bottom, .padding30)
            .padding(.horizontal, .padding16)
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Strings.addButtonTitle)
        .onTapGesture(perform: viewModel.dismissKeyboard)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.clear)
        .onAppear(perform: viewModel.onViewAppear)
        .sheet(isPresented: $viewModel.isGalleryVisible) {
            PhotoCollectionView(
                didSelect: viewModel.didSelect(photo:),
                collection: viewModel.photoCollection
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }
    
    private var saveButton: some View {
        CButton(
            title: Strings.saveButtonTitle,
            isEnabled: viewModel.canSaveContact,
            tintColor: .redClaro,
            action: viewModel.onSaveContact
        )
        .padding(.vertical, .padding16)
    }
    
    private func setupEditIcon() -> some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: .editIconSize, height: .editIconSize)
            .foregroundStyle(.redClaro)
            .padding(.top, .padding12)
    }
}

// MARK: - Constants

private extension CGFloat {
    static let padding12: CGFloat = 12
    static let padding16: CGFloat = 16
    static let padding30: CGFloat = 30
    static let editIconSize: CGFloat = 26
    static let profileWidth: CGFloat = 150
    static let profileHeight: CGFloat = 150
}
