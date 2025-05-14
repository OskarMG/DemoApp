//
//  EmptyStateView.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 14/5/25.
//

import SwiftUI

/// `EmptyStateAction` is an input to pass a label and an action as needed
struct EmptyStateAction {
    let label: String
    let action: () -> Void
}

/// A reusable view that represents an empty state in the UI,
struct EmptyStateView: View {
    /// The name of the system image to display as an icon. Optional.
    var icon: String?
    
    /// The message describing the empty state.
    var message: String
    
    /// The color used to tint the icon and text.
    var tint: Color
    
    /// An optional action with a button and callback to be displayed below the message.
    let action: EmptyStateAction?
    
    init(
        icon: String? = nil,
        message: String,
        tint: Color = .redClaro,
        action: EmptyStateAction? = nil
    ) {
        self.icon = icon
        self.message = message
        self.tint = tint
        self.action = action
    }

    var body: some View {
        VStack(spacing: .padding12) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: .size20))
                    .foregroundColor(tint.opacity(.opacity))
                    .padding()
            }

            Text(message)
                .font(.headline)
                .foregroundColor(tint)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if let action {
                Button(action: action.action) {
                    Text(action.label)
                        .foregroundColor(tint)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}

// MARK: - Constants

private extension Double {
    static let opacity: Double = 0.6
}

private extension CGFloat {
    static let size20: CGFloat = 40
    static let padding12: CGFloat = 12
}
