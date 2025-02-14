//
// File name: TaskCreateViewModel.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI
import CoreLocation

@Observable
class TaskCreateViewModel: ObservableObject {
    //MARK: - Reference properties
    var title: String  = "" { didSet { isDirty = true } }
    var category: String = "" { didSet { isDirty = true } }
    var importance: TaskImportance = .medium  { didSet { isDirty = true } }
    var plannedDate: Date = Date() { didSet { isDirty = true } }
    var reminderDate: Date = Date() { didSet { isDirty = true } }
    
    var selectedImage: UIImage? = nil { didSet { isDirty = true } }
    var link: String = "" { didSet { isDirty = true } }
    
    var isPhotoOn: Bool = false { didSet { isDirty = true } }
    var isReminderOn: Bool = false { didSet { isDirty = true } }
    var isAddToCalendar: Bool = false
    
    
    //MARK: - Alerts flags
    var showPhotoAlert: Bool = false
    var showNotificationAlert: Bool = false
    var showEventAlert: Bool = false
    var showEmptyTitleAlert: Bool = false
    //MARK: - Flag properties
    
    var showPhotoPicker = false
    var showCameraController: Bool = false
    var showTypesImages: Bool = false
    var showUnsavedChangesAlert: Bool = false
    var showsSavingToCalendar: Bool = false
    
    var isDirty: Bool = false
    
    private let photoManager = PhotoLibraryManager.shared
    private let eventManager = CalendarManager.shared
    private let notificationManager = NotificationManager.shared
    private var notificationIdentifier: String?
    
    func toggleCalendarAccess(isOn: Bool){
        if isOn {
            eventManager.requestAccess { isAccessed, _ in
                DispatchQueue.main.async {
                    self.isAddToCalendar = isAccessed
                    self.showEventAlert = !isAccessed
                }
            }
        } else {
            self.isAddToCalendar = false
        }
    }
    
    func toggleNotificationAccess(isOn: Bool){
        if isOn {
            notificationManager.requestAuthorization { isAccessed in
                DispatchQueue.main.async {
                    self.isReminderOn = isAccessed
                    self.showNotificationAlert = !isAccessed
                }
            }
        } else {
            self.isReminderOn = false
        }
    }
    
    func togglePhotoAccess(isOn: Bool){
        if isOn {
            photoManager.checkAuthorizationStatus { [weak self] isSuccess in
                DispatchQueue.main.async {
                    self?.isPhotoOn = isSuccess
                    self?.showPhotoAlert = !isSuccess
                }
            }
        } else {
            withAnimation {
                isPhotoOn = false
            }
        }
    }
    
    func createNewTask() -> TaskModel {
        let image = isPhotoOn ? selectedImage : nil
        return TaskModel(title: title,
                         category: category,
                         importance: importance,
                         isCompleted: false,
                         image: selectedImage != nil && isPhotoOn ? image!.jpegData(compressionQuality: 1.0) : nil,
                         link: URL(string: link)?.checkValidation(),
                         creationDate: plannedDate,
                         notificationDate: isReminderOn ? reminderDate : nil,
                         addedToEvent: isAddToCalendar)
    }
    
    func scheduleNotificationIfNeeded(){
        guard isReminderOn else { return }
        notificationManager.requestAuthorization { isAccessed in
            if isAccessed {
                NotificationManager.shared.scheduleNotification(
                    title: "Planned Notification",
                    body: self.title.isEmpty ? "You are getting a reminder because of setup a task" : self.title,
                    date: self.reminderDate) { success in
                        print("Notification scheduled: \(success)")
                    }
            } else {
                print("User did not allow sending notifications✅")
            }
        }
    }
    
    func addTaskToEvent(){
        guard isAddToCalendar else { return }
        eventManager.addTaskToCalendar(createNewTask()) { isSaved, error in
            guard isSaved && error == nil else {
                print("Failed to save event: \(String(describing: error?.localizedDescription))⛔️")
                return
            }
            print("Event saved successfully✅")
        }
    }
    
    func openSettings(){
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}
