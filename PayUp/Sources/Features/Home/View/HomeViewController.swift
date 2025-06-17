//
//  HomeViewController.swift
//  PayUp
//
//  Created by Arthur Rios on 01/05/25.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    private let homeView = HomeView()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
}
