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
    var title: String = ""
    var category: String = ""
    var importance: TaskImportance = .medium
    var plannedDate: Date = Date()
    var isReminderOn: Bool = false
    var reminderDate: Date = Date()
    var isPhotoOn: Bool = false
    var selectedImage: UIImage? = nil
    var location: CLLocationCoordinate2D? = nil
    var link: String = ""
    
    var showPhotoPicker = false
    private let photoManager = PhotoLibraryManager.shared
    
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
    
    func createNewTask() -> TaskModel {
        return TaskModel(title: title,
                         category: category,
                         importance: importance,
                         isCompleted: false,
                         image: selectedImage != nil ? selectedImage!.jpegData(compressionQuality: 1.0) : nil,
                         link: URL(string: link),
                         place: location,
                         creationDate: plannedDate,
                         notificationDate: isReminderOn ? reminderDate : nil)
    }
}
