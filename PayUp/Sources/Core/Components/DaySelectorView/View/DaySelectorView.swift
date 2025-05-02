//
//  DaySelectorView.swift
//  PayUp
//
//  Created by Arthur Rios on 01/05/25.
//

import Foundation
import UIKit

final class DaySelectorView: UIView {
    
    private let viewModel = DaySelectorViewModel()
    private var buttons: [UIButton] = []
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(scrollView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func setupButtons() {
        for (index, day) in viewModel.days.enumerated() {
            var configuration = UIButton.Configuration.filled()
            configuration.title = day
            configuration.baseBackgroundColor = Colors.backgroundTertiary
            configuration.baseForegroundColor = Colors.textHeading
            configuration.cornerStyle = .fixed
            configuration.contentInsets = .zero
            
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 6
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.clear.cgColor
            button.titleLabel?.font = Fonts.titleExtraSmall()
            button.heightAnchor.constraint(equalToConstant: 32).isActive = true
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
            button.tag = index
//            button.addTarget(self, action: #selector(dayTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
}
