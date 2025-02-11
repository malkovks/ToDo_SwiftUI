//
// File name: NotificationManager.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 10.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI
import UserNotifications

final class NotificationManager: NSObject {
    static let shared = NotificationManager()
    
    private override init() {}
    
    func requestAuthorization(completion: @escaping (_ isAccessed: Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isAccessed, error in
            DispatchQueue.main.async {
                completion(isAccessed)
            }
        }
    }
    
    func scheduleNotification(title: String, body: String, date: Date, identifier: String = UUID().uuidString, completion: ((_ isError: Bool) -> Void)? = nil){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .defaultRingtone
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute,.second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            DispatchQueue.main.async {
                completion?(error != nil)
            }
        }
    }
}
