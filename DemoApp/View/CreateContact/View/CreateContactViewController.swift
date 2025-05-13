//
//  CreateContactViewController.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import UIKit
import SwiftUI

@objc class CreateContactViewController: UIViewController {
    let child = UIHostingController(rootView: CreateContactView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSwiftUIView()
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.systemFill
        self.navigationItem.title = Strings.createContactTitle
        self.navigationItem.rightBarButtonItem = BarButton.create(
            title: Strings.cancelButtonTitle,
            target: self,
            action: #selector(onCancelTap)
        )
    }
    
    /// Setup SwiftUI View
    private func setupSwiftUIView() {
        addChild(child)
        child.view.frame = view.bounds
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    @objc private func onCancelTap() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
