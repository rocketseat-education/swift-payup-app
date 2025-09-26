//
//  ClientFormViewModel.swift
//  PayUp
//
//  Created by Arthur Rios on 11/08/25.
//

import Foundation

final class ClientFormViewModel {
    private let databaseManager = DatabaseManager.shared
    private let notificationManager = NotificationManager.shared
    
    func saveClient(client: Client) -> Bool {
        if let savedClientId = databaseManager.saveClientAndReturnId(client) {
            if client.isRecurring {
                let clientWithId = Client(
                    id: savedClientId,
                    name: client.name,
                    contact: client.contact,
                    phone: client.phone,
                    cnpj: client.cnpj,
                    address: client.address,
                    value: client.value,
                    dueDate: client.dueDate,
                    isRecurring: client.isRecurring,
                    frequency: client.frequency
                )
                notificationManager.scheduleClientReminders(for: clientWithId)
            } else {
                print("Cliente não colocou um lembrete")
            }
            return true
        }
        return false
    }
    
    func getAllClients() -> [Client] {
        return databaseManager.getClients()
    }
    
    func getClientById(id: Int) -> Client? {
        return databaseManager.getClient(by: id)
    }
    
    func deleteClient(by id: Int) -> Bool {
        notificationManager.cancelClientReminders(clientId: id)
        return databaseManager.deleteClient(by: id)
    }
}
