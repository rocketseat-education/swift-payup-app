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
        let view = PaymentCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(logoImage)
        addSubview(profileImage)
        addSubview(bellButton)
        addSubview(daySelectorView)
        addSubview(paymentCardView)
        
        let companyListView = CompanyListView(companies: mockCompanies)
        addSubview(companyListView)
        
        daySelectorView.translatesAutoresizingMaskIntoConstraints = false
        paymentCardView.translatesAutoresizingMaskIntoConstraints = false
        companyListView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -24),
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
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
            daySelectorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            daySelectorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            daySelectorView.heightAnchor.constraint(equalToConstant: 32),
            
            paymentCardView.topAnchor.constraint(equalTo: daySelectorView.bottomAnchor, constant: 20),
            paymentCardView.leadingAnchor.constraint(equalTo: daySelectorView.leadingAnchor),
            paymentCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            paymentCardView.heightAnchor.constraint(equalToConstant: 95),
            
            companyListView.topAnchor.constraint(equalTo: paymentCardView.bottomAnchor, constant: 24),
            companyListView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            companyListView.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyListView.heightAnchor.constraint(equalToConstant: 141)
        ])
    }
    
    private func setupCollectionView() {
        // vai ser aqui no futuro
    }
    
    private func setupPaymentCard() {
        let transactionModel = PaymentCardModel(type: .transaction, name: "Aurora Tech Soluções Digitais", value: "R$ 250,00")
        paymentCardView.configure(with: transactionModel)
    }
}
