//
//  CreateContactView.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import SwiftUI

struct CreateContactView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                Text("Hey Claro !!!")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Strings.addButtonTitle)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.clear)
    }
}

#Preview {
    CreateContactView()
}
