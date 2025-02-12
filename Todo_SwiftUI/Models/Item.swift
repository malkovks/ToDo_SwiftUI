//
// File name: Item.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 08.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import Foundation
import SwiftData
import CoreLocation

@Model
final class Item {
    var id: UUID
    var title: String
    var category: String
    var importance: String
    var isCompleted: Bool = false
    var image: Data? = nil
    var link: URL? = nil
    var creationDate: Date = Date()
    var notificationDate: Date? = nil
    
    init(_ taskModel: TaskModel){
        self.id = taskModel.id
        self.title = taskModel.title
        self.category = taskModel.category
        self.importance = taskModel.importance.rawValue
        self.isCompleted = taskModel.isCompleted
        self.image = taskModel.image
        self.link = taskModel.link
        self.creationDate = taskModel.creationDate
        self.notificationDate = taskModel.notificationDate
    }
}
