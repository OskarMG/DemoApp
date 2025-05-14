//
//  FormInput.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import SwiftUI

struct FormInput: View {
    @Binding private var input: String
    private let placeHolder: String
    private let keyboardType: UIKeyboardType

    init(
        input: Binding<String>,
        placeHolder: String,
        keyboardType: UIKeyboardType = .default
    ) {
        self._input = input
        self.placeHolder = placeHolder
        self.keyboardType = keyboardType
    }

    var body: some View {
        HStack(spacing: .zero) {
            TextField(placeHolder, text: $input)
                .padding(.padding10)
                .background(Color(.systemGray6))
                .cornerRadius(.cornerRadius)
                .keyboardType(keyboardType)
        }
        .padding(.top, .padding10)
    }
}

// MARK: - Constants

private extension CGFloat {
    static let padding10: CGFloat = 10
    static let cornerRadius: CGFloat = 8
}
