//
//  ClientFormView.swift
//  PayUp
//
//  Created by Arthur Rios on 30/06/25.
//

import UIKit

final class ClientFormView: UIView {
    private let mode: ClientFormMode
    weak var delegate: ClientFormViewDelegate?
    
    private let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = Colors.backgroundPrimary
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(mode: ClientFormMode) {
        self.mode = mode
        super.init(frame: .zero)
        backgroundColor = Colors.backgroundPrimary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
