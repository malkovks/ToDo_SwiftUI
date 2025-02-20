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
        
        let soundName = UserDefaults.standard.string(forKey: "notificationSound") ?? "Default"
        
        if soundName == "Default" {
            content.sound = .default
        } else {
            content.sound = UNNotificationSound(named: UNNotificationSoundName(configureSoundName(key: soundName)))
        }
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute,.second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            DispatchQueue.main.async {
                completion?(error != nil)
            }
        }
    }
    
    
    private func configureSoundName(key: String) -> String {
        switch key {
        case "Sound 1" :
            return "mixkit-confirmation-tone-2867.wav"
        case "Sound 2":
            return "mixkit-correct-answer-tone-2870.wav"
        case "Sound 3":
            return "mixkit-message-pop-alert-2354.wav"
        case "Sound 4":
            return "mixkit-software-interface-start-2574.wav"
        default:
            return "Default"
        }
    }
}
