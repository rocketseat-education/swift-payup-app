//
//  HomeView.swift
//  PayUp
//
//  Created by Arthur Rios on 01/05/25.
//

import Foundation
import UIKit

final class HomeView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mainLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bellButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "bell"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Colors.textHeading
        return button
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profileImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    let daySelectorView: DaySelectorView = {
        let view = DaySelectorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let paymentCardView: PaymentCardView = {
        let card = PaymentCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let addClientsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar client", for: .normal)
        button.titleLabel?.font = Fonts.paragraphMedium()
        button.backgroundColor = Colors.accentBrand
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
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
        button.setTitle("Filtrar", for: .normal)
        button.titleLabel?.font = Fonts.titleSmall()
        button.setTitleColor(Colors.accentBrand, for: .normal)
        return button
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filtrar", for: .normal)
        button.titleLabel?.font = Fonts.paragraphMedium()
        button.setTitleColor(Colors.textHeading, for: .normal)
        button.tintColor = Colors.textHeading
        button.backgroundColor = Colors.backgroundSecondary
        button.layer.cornerRadius = 6
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -4)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        return button
    }()
    
    private let transactionCardView: PaymentCardView = {
        let card = PaymentCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    private let companyListView: CompanyListView = {
        let companies = [
            CompanyItemModel(name: "Aurora Tech Soluções Digitais"),
            CompanyItemModel(name: "Veltrix Labs"),
            CompanyItemModel(name: "Rocketseat"),
            CompanyItemModel(name: "ApertaAi Replays"),
        ]
        let view = CompanyListView(companies: companies)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        setupPaymentCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Colors.backgroundPrimary
        addSubview(scrollView)
        scrollView.addSubview(contentView)
//        addSubview(logoImage)
//        addSubview(profileImage)
//        addSubview(bellButton)
//        addSubview(daySelectorView)
//        addSubview(paymentCardView)
//        
//        let companyListView = CompanyListView(companies: mockCompanies)
//        addSubview(companyListView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
        
        setupViewsOnScroll()
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -24),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            logoImage.heightAnchor.constraint(equalToConstant: 24),
            logoImage.widthAnchor.constraint(equalToConstant: 82),
            
            profileImage.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            profileImage.heightAnchor.constraint(equalToConstant: 44),
            profileImage.widthAnchor.constraint(equalToConstant: 44),
            
            bellButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            bellButton.trailingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: -24),
            bellButton.heightAnchor.constraint(equalToConstant: 24),
            bellButton.widthAnchor.constraint(equalToConstant: 24),
            
            daySelectorView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 55),
            daySelectorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            daySelectorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            daySelectorView.heightAnchor.constraint(equalToConstant: 32),
            
            todayLabel.topAnchor.constraint(equalTo: daySelectorView.bottomAnchor, constant: 24),
            todayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            paymentCardView.topAnchor.constraint(equalTo: daySelectorView.bottomAnchor, constant: 20),
            paymentCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            paymentCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            paymentCardView.heightAnchor.constraint(equalToConstant: 95),
            
            addClientsButton.topAnchor.constraint(equalTo: paymentCardView.bottomAnchor, constant: 24),
            addClientsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            addClientsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            addClientsButton.heightAnchor.constraint(equalToConstant: 48),
            
            viewAllButton.topAnchor.constraint(equalTo: addClientsButton.bottomAnchor, constant: 24),
            viewAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            viewAllButton.heightAnchor.constraint(equalToConstant: 24),
            
            companyListView.topAnchor.constraint(equalTo: paymentCardView.bottomAnchor, constant: 24),
            companyListView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            companyListView.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyListView.heightAnchor.constraint(equalToConstant: 141),
            
            transactionLabel.topAnchor.constraint(equalTo: companyListView.bottomAnchor, constant: 24),
            transactionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            filterButton.centerYAnchor.constraint(equalTo: transactionLabel.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            filterButton.heightAnchor.constraint(equalToConstant: 44),
            
            transactionDateLabel.topAnchor.constraint(equalTo: transactionLabel.bottomAnchor, constant: 16),
            transactionDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            transactionCardView.topAnchor.constraint(equalTo: transactionDateLabel.bottomAnchor, constant: 8),
            transactionCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            transactionCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            transactionCardView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    private func setupViewsOnScroll() {
        let views: [UIView] = [
            logoImage,
            bellButton,
            profileImage,
            daySelectorView,
            todayLabel,
            paymentCardView,
            addClientsButton,
            viewAllButton,
            companyListView,
            transactionLabel,
            filterButton,
            transactionDateLabel,
            transactionCardView
        ]
        views.forEach { contentView.addSubview($0) }
    }
    
    private func setupCollectionView() {
        // vai ser aqui no futuro
    }
    
    private func setupPaymentCard() {
        paymentCardView.configure(with: .init(type: .incoming,
                                              name: "Aurora Tech Soluções Digitais",
                                              value: "R$ 250,00"))
        transactionCardView.configure(with: .init(type: .transaction,
                                              name: "Duna Sports",
                                              value: "R$ 450,00"))
    }
}
