//
//  ProfileView.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import SwiftUI

/// A view that displays an image loaded asynchronously from a URL,
struct ProfileView: View {
    private let strURL: String?
    private let contentMode: ContentMode
    private let width, height: CGFloat

    /// Creates a new `PosterView`.
    /// - Parameters:
    ///   - url: A string representing the image URL.
    ///   - contentMode: How the image scales to fit its space. Defaults to `.fill`.
    ///   - width: The width of the image. Defaults to `100`.
    ///   - height: The height of the image. Defaults to `100`.
    init(
        url: String?,
        contentMode: ContentMode = .fill,
        width: CGFloat = 100,
        height: CGFloat = 100
    ) {
        self.strURL = url
        self.width = width
        self.height = height
        self.contentMode = contentMode
    }

    var body: some View {
        if let strURL {
            AsyncImage(url: URL(string: strURL)) { phase in
                switch phase {
                case .empty:
                    LoadingView(tint: .redClaro)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: contentMode)
                case .failure:
                    placeholder
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: width, height: height)
            .clipShape(Circle())
        } else {
            placeholder
        }
    }

    private var placeholder: some View {
        Image(systemName: "photo.circle")
            .resizable()
            .foregroundColor(.redClaro)
            .frame(width: width, height: height)
            .aspectRatio(contentMode: contentMode)
            .clipShape(Circle())
    }
}
