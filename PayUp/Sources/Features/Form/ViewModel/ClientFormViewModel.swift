//
//  ClientFormViewModel.swift
//  PayUp
//
//  Created by Arthur Rios on 11/08/25.
//

import Foundation

final class ClientFormViewModel {
    private let databaseManager = DatabaseManager.shared
    
    func saveClient(client: Client) -> Bool {
        return databaseManager.saveClient(client)
    }
    
    func getAllClients() -> [Client] {
        return databaseManager.getClients()
    }
    
    func getClientById(id: Int) -> Client? {
        return databaseManager.getClient(by: id)
    }
    
    func deleteClient(by id: Int) -> Bool {
        return databaseManager.deleteClient(by: id)
    }
}
