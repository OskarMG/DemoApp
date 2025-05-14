//
//  CButton.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import SwiftUI

struct CButton: View {
    let title: String
    let isEnabled: Bool
    let tintColor: Color
    let action: () -> Void
    
    private var opacity: Double {
        isEnabled ? .opacity1 : .opacity05
    }

    private var background: Color {
        isEnabled ? tintColor : tintColor.opacity(.opacity05)
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(background)
                .foregroundColor(.white)
                .cornerRadius(.cornerRadius)
        }
        .opacity(opacity)
        .disabled(!isEnabled)
    }
}

// MARK: - Constants

private extension Double {
    static let opacity1: CGFloat = 1
    static let opacity05: CGFloat = 0.5
}

private extension CGFloat {
    static let cornerRadius: CGFloat = 12
}
