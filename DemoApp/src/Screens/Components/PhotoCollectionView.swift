//
//  PhotoCollectionView.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 14/5/25.
//

import SwiftUI

struct PhotoCollectionView: View {
    private let collection: PictureResponse
    private let didSelect: (Picture) -> Void
        
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(
        didSelect: @escaping (Picture) -> Void,
        collection: PictureResponse
    ) {
        self.didSelect = didSelect
        self.collection = collection
    }

    var body: some View {
        if collection.isEmpty {
            EmptyStateView(
                icon: "photo.on.rectangle.angled",
                message: Strings.emptyMessageForPhotoCollection,
                action: .init(
                    label: Strings.tryAgainLabel,
                    action: {
                        // handle failure | Ask UX Team
                    }
                )
            )
        } else {
            ScrollView {
                VStack(spacing: .padding20) {
                    Text(Strings.galleryTitle)
                        .bold()
                    LazyVGrid(columns: columns, spacing: .columnSpacing) {
                        ForEach(collection, id: \.id) { photo in
                            Button(action: { didSelect(photo) }) {
                                ProfileView(
                                    url: photo.url,
                                    contentMode: .fill
                                )
                                .padding(.bottom, .padding20)
                            }
                        }
                    }
                }
            }
            .padding(.vertical, .padding20)
            .padding(.horizontal, .padding16)
        }
    }
}

#Preview {
    PhotoCollectionView(
        didSelect: { _ in },
        collection: []
    )
}

// MARK: - Constants
private extension CGFloat {
    static let padding16: CGFloat = 16
    static let padding20: CGFloat = 20
    static let columnSpacing: CGFloat = 10
}
