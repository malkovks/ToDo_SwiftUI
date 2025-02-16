//
// File name: TaskModel.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct TaskModel: Identifiable {
    var id: UUID = UUID()
    var title: String
    var category: String
    var importance: TaskImportance
    var isCompleted: Bool = false
    var image: Data? = nil
    var link: URL? = nil
    var creationDate: Date = Date()
    var plannedCompleteDate: Date = Date()
    var notificationDate: Date? = nil
    var addedToEvent: Bool = false
    
    init (title: String,
          category: String,
          importance: TaskImportance,
          isCompleted: Bool = false,
          image: Data? = nil,
          link: URL? = nil,
          creationDate: Date = Date(),
          notificationDate: Date? = nil,
          addedToEvent: Bool = false
    ) {
        self.title = title
        self.category = category
        self.importance = importance
        self.isCompleted = isCompleted
        self.image = image
        self.link = link
        self.plannedCompleteDate = creationDate
        self.notificationDate = notificationDate
        self.addedToEvent = addedToEvent
    }
    
    init(_ taskModel: Item){
        self.id = taskModel.id
        self.title = taskModel.title
        self.category = taskModel.category
        self.importance = TaskImportance(rawValue: taskModel.importance.capitalized) ?? .medium
        self.isCompleted = taskModel.isCompleted
        self.image = taskModel.image
        self.link = taskModel.link
        self.creationDate = taskModel.creationDate
        self.plannedCompleteDate = taskModel.plannedCompleteDate
        self.notificationDate = taskModel.notificationDate
        self.addedToEvent = taskModel.addedToEvent
    }
}


