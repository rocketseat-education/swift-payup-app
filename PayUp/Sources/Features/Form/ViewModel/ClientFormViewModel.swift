//
//  ClientFormViewModel.swift
//  PayUp
//
//  Created by Arthur Rios on 11/08/25.
//

import Foundation

final class ClientFormViewModel {
    private let databaseManager = DatabaseManager.shared
    
    func saveClient(client: Client) {
//        let cleanValue = value?.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ",", with: "")
        
        let doubleValue = Double(cleanValue) ?? 0.0
        
        return databaseManager.saveClient(client)
    }
    
    func getAllClients() -> [Client] {
        return databaseManager.getClients()
    }
}
