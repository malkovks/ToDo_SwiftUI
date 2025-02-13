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
    var title: String { didSet { isDirty = true } }
    var category: String  { didSet { isDirty = true } }
    var importance: TaskImportance  { didSet { isDirty = true } }
    var plannedDate: Date  { didSet { isDirty = true } }
    var reminderDate: Date  { didSet { isDirty = true } }
    var isPhotoOn: Bool  { didSet { isDirty = true } }
    var selectedImage: UIImage?  { didSet { isDirty = true } }
    var link: String { didSet { isDirty = true } }
    
    var isReminderOn: Bool  {
        didSet {
            isDirty = true
            guard isReminderOn else { return }
            NotificationManager.shared.requestAuthorization { isAccessed in
                print("isAccessed for manager: \(isAccessed)")
            }
        }
    }
    
    var isAddToCalendar: Bool {
        didSet {
            guard isAddToCalendar else { return }
            eventManager.requestAccess { granted, error in
            }
        }
    }
    
    //MARK: - Flag properties
    
    var showPhotoPicker = false
    var showCameraController: Bool = false
    var showTypesImages: Bool = false
    var showUnsavedChangesAlert: Bool = false
    var showsSavingToCalendar: Bool = false
    
    
    
    var isDirty: Bool = false
    var isDataEdited: Bool
    var isStartEditing: Bool = false
    
    private let photoManager = PhotoLibraryManager.shared
    private let eventManager = CalendarManager.shared
    private var notificationIdentifier: String?
    
    var alertText: String {
        isDataEdited ? "Dou you want to submit edits for your task?" : "You have some unsaved changes. Are you sure you want to leave?"
    }
    
    var buttonText: String {
        isDataEdited ? "Update current task" : "Save New Task"
    }
    
    init(taskModel: TaskModel,isDataEdited: Bool){
        self.isDataEdited = isDataEdited
        self.title = taskModel.title
        self.category = taskModel.category
        self.importance = taskModel.importance
        self.plannedDate = taskModel.creationDate
        self.isReminderOn = taskModel.notificationDate != nil
        self.reminderDate = taskModel.notificationDate ?? Date()
        self.isPhotoOn = taskModel.image != nil
        self.link = taskModel.link?.absoluteString ?? ""
        self.isAddToCalendar = taskModel.addedToEvent
        if let data = taskModel.image {
            self.selectedImage = UIImage(data: data)
        }
        
    }
    
    @MainActor
    func saveImage(){
        guard let image = selectedImage else { return }
        photoManager.saveImageTolibrary(image) { isSuccess in
            print("Image saved: \(isSuccess)")
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
                         notificationDate: isReminderOn ? reminderDate : nil)
    }
    
    func scheduleNotificationIfNeeded(){
        guard isReminderOn else { return }
        NotificationManager.shared.requestAuthorization { isAccessed in
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
                print("Failed to save event: \(String(describing: error?.localizedDescription))")
                return
            }
            print("Event saved successfully✅")
        }
    }
}
