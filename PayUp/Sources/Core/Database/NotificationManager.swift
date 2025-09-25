//
//  NotificationManager.swift
//  PayUp
//
//  Created by Arthur Rios on 25/09/25.
//

import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func scheduleClientReminders(for client: Client) {
        print("Cliente \(client)")
        guard client.isRecurring else { return }
        
        //cancelClientReminder
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let firstDate = dateFormatter.date(from: client.dueDate) else {
            print("Erro ao pegar data do cliente")
            return
        }
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus != .authorized {
                print("Erro, notificações não autorizadas, implementar retry para pedir notificações de novo, ou alert")
                return
            }
            
            DispatchQueue.main.async {
                self.scheduleNotificationsLoop(for: client, startingFrom: firstDate)
            }
        }
        
        print("")
    }
    
    private func scheduleNotificationsLoop(for client: Client, startingFrom firstDate: Date) {
        let maxNotifications = 64
        var scheduleCount = 0
        var currentDate = firstDate
        
        while scheduleCount < maxNotifications {
            scheduleNotification(for: client, on: currentDate)
            scheduleCount += 1
            
            guard let nextDate = calculateNextDate(from: currentDate, frequency: client.frequency, selectedDay: client.selectedDay) else {
                break
            }
            
            currentDate = nextDate
            
        }
    }
    
    private func scheduleNotification(for client: Client, on date: Date) {
        
    }
}
