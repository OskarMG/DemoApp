//
//  String+IsNotEmptyOrWhiteSpace.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import Foundation

/// `isNotEmptyOrWhitespace` that the current string isn't empty or contains white spaces
extension String {
    var isNotEmptyOrWhitespace: Bool {
        return !trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
