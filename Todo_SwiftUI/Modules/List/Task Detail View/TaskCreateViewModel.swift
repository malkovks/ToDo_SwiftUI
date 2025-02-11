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
    
    var title: String = "" { didSet { isDirty = true } }
    var category: String = "" { didSet { isDirty = true } }
    var importance: TaskImportance = .medium { didSet { isDirty = true } }
    var plannedDate: Date = Date() { didSet { isDirty = true } }
    var isReminderOn: Bool = false { didSet { isDirty = true } }
    var reminderDate: Date = Date() { didSet { isDirty = true } }
    var isPhotoOn: Bool = false { didSet { isDirty = true } }
    var selectedImage: UIImage? = nil { didSet { isDirty = true } }
    var location: CLLocationCoordinate2D? = nil { didSet { isDirty = true } }
    var link: String = "" { didSet { isDirty = true } }
    
    var showPhotoPicker = false
    var showCameraController: Bool = false
    var showTypesImages: Bool = false
    var showUnsavedChangesAlert: Bool = false
    var isDirty: Bool = false
    
    private let photoManager = PhotoLibraryManager.shared
    private var notificationIdentifier: String?
    
    init(taskModel: TaskModel){
        self.title = taskModel.title
        self.category = taskModel.category
        self.importance = taskModel.importance
        self.plannedDate = taskModel.creationDate
        self.isReminderOn = taskModel.notificationDate != nil
        self.isPhotoOn = taskModel.image != nil
        self.location = taskModel.place
        self.link = taskModel.link?.absoluteString ?? ""
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
    
    @MainActor
    func openPhotoPicker(){
        photoManager.selectedImage = nil
    }
    
    func openCamere(){
        print("Open Camera")
    }
    
    func createNewTask() -> TaskModel {
        let image = isPhotoOn ? selectedImage : nil
        return TaskModel(title: title,
                         category: category,
                         importance: importance,
                         isCompleted: false,
                         image: selectedImage != nil && isPhotoOn ? image!.jpegData(compressionQuality: 1.0) : nil,
                         link: URL(string: link),
                         place: location,
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
                print("User did not allow sending notifications")
            }
        }
    }
}
