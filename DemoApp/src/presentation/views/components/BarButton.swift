//
//  BarButton.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import UIKit

/// `BarButton` factory
@objcMembers
public class BarButton: NSObject {
    @MainActor public static func create(
        title: String,
        style: UIBarButtonItem.Style = .plain,
        target: Any? = nil,
        action: Selector? = nil
    ) -> UIBarButtonItem {
        return UIBarButtonItem(title: title, style: style, target: target, action: action)
    }
}
