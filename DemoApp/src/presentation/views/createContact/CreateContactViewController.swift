//
//  CreateContactViewController.swift
//  DemoApp
//
//  Created by Oscar Martínez Germán on 13/5/25.
//

import UIKit
import SwiftUI

@objc class CreateContactViewController: UIViewController {
    @objc private weak var contactDelegate: ContactDelegate?
    
    @objc init(
        contactDelegate: ContactDelegate?
    ) {
        super.init(nibName: nil, bundle: nil)
        self.contactDelegate = contactDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            action: #selector(dismissVC)
        )
    }
    
    /// Setup SwiftUI View
    private func setupSwiftUIView() {
        let viewModel = CreateContactViewModel(
            contactDelegate: contactDelegate,
            wrapperDelegate: self
        )
        let child = UIHostingController(rootView: CreateContactView(viewModel: viewModel))
        
        addChild(child)
        child.view.frame = view.bounds
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    @objc private func dismissVC() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension CreateContactViewController: @preconcurrency CreateContactWrapperDelegate {
    func didDismiss() { dismissVC() }
}
