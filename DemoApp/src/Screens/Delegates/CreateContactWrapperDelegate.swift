//
//  CreateContactWrapperDelegate.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 14/5/25.
//

import Foundation

/// A `Delegate` for the Create Contact View to exposed `UIKit` methods to `SwiftUI`
protocol CreateContactWrapperDelegate: AnyObject {
    func didDismiss()
}
