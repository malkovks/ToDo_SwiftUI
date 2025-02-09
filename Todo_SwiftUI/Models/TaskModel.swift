//
// File name: TaskModel.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI
import CoreLocation

struct TaskModel: Identifiable {
    let id = UUID()
    var title: String
    var category: String
    var importance: TaskImportance
    var isCompleted: Bool = false
    var image: Data? = nil
    var link: URL? = nil
    var place: CLLocationCoordinate2D? = nil
    var creationDate: Date = Date()
    var notificationDate: Date? = nil
}

enum TaskImportance {
    case high, medium, low
}
