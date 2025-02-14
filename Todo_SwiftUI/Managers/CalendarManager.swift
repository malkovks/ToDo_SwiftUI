//
// File name: CalendarManager.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 13.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import EventKit

class CalendarManager: NSObject {
    static let shared = CalendarManager()
    
    private let eventStore: EKEventStore = .init()
    
    private override init(){}
    
    func requestAccess(completion: @escaping (_ granted: Bool,_ error: Error?) -> Void){
        eventStore.requestWriteOnlyAccessToEvents { granted, error in
            DispatchQueue.main.async {
                completion(granted,error)
            }
        }
    }
    
    //Check correction work of saving task to EKEvent
    func addTaskToCalendar(_ task: TaskModel, completion: @escaping (Bool,Error?) -> Void?){
        requestAccess { granted, error in
            guard granted else {
                completion(false,error)
                return
            }
        }
        let event = EKEvent(eventStore: eventStore)
        event.title = task.title
        event.startDate = task.creationDate
        event.endDate = task.notificationDate ?? task.creationDate.addingTimeInterval(3660)
        event.availability = .free
        event.url = task.link
        
        do {
            try self.eventStore.save(event, span: .thisEvent)
            completion(true,nil)
        } catch {
            completion(false,error)
        }
    }
}
