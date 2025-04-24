//
//  SplashView.swift
//  PayUp
//
//  Created by Arthur Rios on 23/04/25.
//

import Foundation
import UIKit

final class SplashView: UIView {
    
    let triangleImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "animatedSplashTriangle"))
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0
        return imageView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mainLogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        return imageView
    }()
    
    let example = InputTextFieldView(title: "CNPJ", placeholder: "CNPJ")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Colors.backgroundPrimary
        addSubview(triangleImageView)
        addSubview(logoImageView)
        addSubview(example)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        triangleImageView.frame = bounds
        logoImageView.center = center
        logoImageView.bounds.size = CGSize(width: 100, height: 100)
        
        example.frame = CGRect(x: 32, y: bounds.height - 200, width: bounds.width - 70, height: 60)
    }
}
