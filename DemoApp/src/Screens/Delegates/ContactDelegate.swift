//
//  ContactDelegate.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 14/5/25.
//

import Foundation

@objc
protocol ContactDelegate: AnyObject {
    func didSave(contact: ContactObjC)
}
