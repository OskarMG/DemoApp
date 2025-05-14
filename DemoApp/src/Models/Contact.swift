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
    
    @objc nonisolated(unsafe) static let defaultValues: [ContactObjC] = [
        .init(name: "Oscar", lastName: "Martínez", phone: "8092050922"),
        .init(name: "Lynn", lastName: "Laia", phone: "8295914062"),
        .init(name: "Zabdi", lastName: "Gil", phone: "8095931167")
    ]
}
