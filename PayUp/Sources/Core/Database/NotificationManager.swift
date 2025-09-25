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
        let content = UNMutableNotificationContent()
        content.title = "Cobrança PayUp"
        content.body = "Lembrete: Cobrança de \(client.name) - \(client.value)"
        content.sound = .default
        content.badge = 1
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        var dateComponents = DateComponents()
        dateComponents.year = components.year
        dateComponents.month = components.month
        dateComponents.day = components.day
        dateComponents.hour = components.hour
        dateComponents.minute = components.minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let identifier = "client_\(client.id ?? 0)_\(date.timeIntervalSince1970)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erro ao agendar a notificação: \(error)")
            } else {
                print("Sucesso ao agendar notificação")
            }
        }
    }
    
    private func calculateNextDate(from date: Date, frequency: String, selectedDay: Int?) -> Date? {
        let calendar = Calendar.current
        
        switch frequency {
        case "Diariamente":
            return calendar.date(byAdding: .day, value: 1, to: date)
        case "Semanalmente":
            return calendar.date(byAdding: .weekOfYear, value: 1, to: date)
        case "Mensalmente":
            if let selectedDay = selectedDay {
                var components = calendar.dateComponents([.year, .month], from: date)
                components.month! += 1
                components.day = selectedDay
                
                if components.month! > 12 {
                    components.year! += 1
                    components.month! -= 12
                }
                
                return calendar.date(from: components)
            } else {
                return calendar.date(byAdding: .month, value: 1, to: date)
            }
        default:
            return nil
        }
    }
}
