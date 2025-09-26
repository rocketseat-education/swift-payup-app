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
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupCallForAddClient()
        setupCompanyListDelegate()
        setupNotificationObserver()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func setupCallForAddClient() {
        homeView.onTapAddClient = { [weak self] in
            guard let self = self else { return }
            let formViewController = ClientFormViewController(mode: .add)
            formViewController.modalTransitionStyle = .coverVertical
            formViewController.modalPresentationStyle = .overFullScreen
            self.present(formViewController, animated: true)
        }
    }
    
    private func loadData() {
        let clients = viewModel.getCompanyModelsFromClients()
        let todayValue = viewModel.getTotalValueForToday()
        let formattedValue = viewModel.formatCurrency(todayValue)
        let todayTransactions = viewModel.getTodayTransactions()
        let todayDateString = viewModel.getTodayDateString()
        
        homeView.updateCompanyList(companies: clients)
        homeView.updateTodayValue(value: formattedValue)
        homeView.updateTransactions(todayTransactions)
        homeView.updateTransactionDate(todayDateString)
    }
    
    private func setupCompanyListDelegate() {
        homeView.setCompanyListDelegate(self)
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleClientDataChanged),
                                               name: .clientDataChanged,
                                               object: nil)
    }
    
    @objc
    private func handleClientDataChanged() {
        loadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension HomeViewController: CompanyListViewDelegate {
    func didSelectCompany(_ company: CompanyItemModel) {
        guard let client = viewModel.getClientByName(company.name) else {
            print("cliente não encontrado para edição")
            return
        }
        
        let formViewController = ClientFormViewController(mode: .edit(client))
        formViewController.modalTransitionStyle = .coverVertical
        formViewController.modalPresentationStyle = .overFullScreen
        self.present(formViewController, animated: true)
    }
}
