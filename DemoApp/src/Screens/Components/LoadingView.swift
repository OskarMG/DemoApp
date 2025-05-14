//
//  LoadingView.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import SwiftUI

/// A reusable loading view with customizable size, tint color, and optional title.
struct LoadingView: View {
    
    /// Defines the visual size of the loading spinner.
    enum Size {
        case small, medium, large
        
        /// The scale factor to apply to the progress indicator.
        var scale: CGFloat {
            switch self {
            case .small: return 0.75
            case .medium: return 1.0
            case .large: return 1.5
            }
        }
        
        /// The frame dimensions (width/height) of the loading indicator.
        var frame: CGFloat {
            switch self {
            case .small: return 20
            case .medium: return 30
            case .large: return 50
            }
        }
    }

    /// The tint color for the spinner and optional title text.
    let tint: Color
    
    /// The visual size of the spinner. Defaults to `.medium`.
    let size: Size
    
    /// An optional string to display below the spinner (e.g., "Loading...").
    let title: String?
    
    init(
        tint: Color,
        size: Size = .medium,
        title: String? = nil
    ) {
        self.tint = tint
        self.size = size
        self.title = title
    }

    var body: some View {
        VStack(spacing: .padding8) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: tint))
                .frame(width: size.frame, height: size.frame)
                .scaleEffect(size.scale)
                .padding()
                .background(Color(tint).opacity(.opacity01))
                .clipShape(Circle())
                .shadow(color: tint.opacity(.opacity03), radius: .radiusX, x: .zero, y: .radiusY)

            if let title {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(tint)
            }
        }
    }
}

// MARK: - Constants

private extension Double {
    static let opacity01: Double = 0.1
    static let opacity03: Double = 0.3
}

private extension CGFloat {
    static let radiusY: CGFloat = 2
    static let radiusX: CGFloat = 4
    static let padding8: CGFloat = 8
}
