//
//  HomeView.swift
//  PayUp
//
//  Created by Arthur Rios on 01/05/25.
//

import Foundation
import UIKit

final class HomeView: UIView {
    var onTapAddClient: (() -> Void)?
    
    // MARK: - Scroll + Container
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 24, right: 24)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerStack: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [logoImage, spacer, bellButton, profileImage])
        stackView.setCustomSpacing(24, after: bellButton)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Subviews
    
    let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mainLogo"))
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 82),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bellButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "bell"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 24),
            button.heightAnchor.constraint(equalToConstant: 24)
        ])
        button.tintColor = Colors.textHeading
        return button
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profileImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 44),
            imageView.heightAnchor.constraint(equalToConstant: 44)
        ])
        return imageView
    }()
    
    let daySelectorView: DaySelectorView = {
        let view = DaySelectorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 32)
        ])
        return view
    }()
    
    let paymentCardView: PaymentCardView = {
        let card = PaymentCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.heightAnchor.constraint(equalToConstant: 95).isActive = true
        return card
    }()
    
    let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Hoje"
        label.font = Fonts.titleSmall()
        label.textColor = Colors.textHeading
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var todayStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            todayLabel, paymentCardView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let addClientButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar cliente", for: .normal)
        button.titleLabel?.font = Fonts.labelMedium()
        button.setTitleColor(Colors.textInvert, for: .normal)
        button.backgroundColor = Colors.accentBrand
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.addTarget(self, action: #selector(didTapAddClient), for: .touchUpInside)
        return button
    }()
    
    private let transactionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lançamentos"
        label.font = Fonts.titleSmall()
        label.textColor = Colors.textHeading
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transactionDateLabel: UILabel = {
        let label = UILabel()
        label.text = "01 de abril"
        label.font = Fonts.titleSmall()
        label.textColor = Colors.textHeading
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ver todos", for: .normal)
        button.titleLabel?.font = Fonts.titleSmall()
        button.setTitleColor(Colors.accentBrand, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return button
    }()
    
    private let transactionCardView: PaymentCardView = {
        let card = PaymentCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.heightAnchor.constraint(equalToConstant: 95).isActive = true
        return card
    }()
    
    private let companyListView: CompanyListView = {
        let view = CompanyListView(companies: [])
        view.heightAnchor.constraint(equalToConstant: 144).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var companySectionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            UIView(), viewAllButton
        ])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filtrar", for: .normal)
        button.titleLabel?.font = Fonts.paragraphMedium()
        button.setTitleColor(Colors.textHeading, for: .normal)
        button.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .normal)
        button.tintColor = Colors.textHeading
        button.backgroundColor = Colors.backgroundSecondary
        button.layer.cornerRadius = 6
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -4)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private lazy var transactionHeaderStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            transactionLabel, UIView(), filterButton
        ])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerStack,
            daySelectorView,
            todayStack,
            addClientButton,
            companySectionStack,
            companyListView,
            transactionHeaderStack,
            transactionDateLabel,
            transactionCardView,
        ])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Colors.backgroundPrimary
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            mainStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }

    // MARK: - Content
    
    private func setupContent() {
//        paymentCardView.configure(with: .init(type: .incoming,
//                                              name: "Aurora Tech Soluções Digitais",
//                                              value: "R$ 250,00"))
        transactionCardView.configure(with: .init(type: .transaction,
                                              name: "Duna Sports",
                                              value: "R$ 450,00"))
    }
    
    @objc
    private func didTapAddClient() {
        onTapAddClient?()
    }
    
    // MARK: - Public Methods
    
    func updateCompanyList(companies: [CompanyItemModel]) {
        companyListView.updateCompanies(companies)
    }
    
    func updateTodayValue(value: String) {
        paymentCardView.configure(
            with: .init(
                type: .incoming,
                name: "Recebimentos de hoje",
                value: value
            )
        )
    }
    
    func setCompanyListDelegate(_ delegate: CompanyListViewDelegate) {
        companyListView.delegate = delegate
    }
}
