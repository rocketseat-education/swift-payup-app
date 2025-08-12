//
//  DatabaseManager.swift
//  PayUp
//
//  Created by Arthur Rios on 11/08/25.
//

import Foundation
import SQLite3

final class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: OpaquePointer?
    
    private init() {
        openDatabase()
        createTable()
    }
    
    private func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        if sqlite3_open(fileURL.path(), &db) != SQLITE_OK {
            print("Unable to open db")
        }
    }
    
    private func createTable() {
        let createTableSQL = """
            CREATE TABLE IF NOT EXISTS clients(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            contact TEXT NOT NULL,
            phone TEXT NOT NULL,
            cnpj TEXT NOT NULL,
            address TEXT NOT NULL,
            value REAL NOT NULL,
            due_date TEXT NOT NULL,
            is_recurring INTEGER NOT NULL,
            frequency TEXT NOT NULL,
            selected_day INTEGER NOT NULL
            );
            """
        
        if sqlite3_exec(db, createTableSQL, nil, nil, nil) != SQLITE_OK {
            print("Unable to create table")
        }
    }
    
    func saveClient(_ client: Client) {
        
    }
}
