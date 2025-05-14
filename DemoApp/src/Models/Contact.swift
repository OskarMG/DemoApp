//
//  Contact.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import Foundation

struct Contact {
    let id: String = UUID().uuidString
    let name, lastName, phone: String
}

/// To be exposed to `Objective C`
@objcMembers
class ContactObjC: NSObject {
    let id, name, lastName, phone: String

    init(name: String, lastName: String, phone: String) {
        self.id = UUID().uuidString
        self.name = name
        self.lastName = lastName
        self.phone = phone
    }
}
