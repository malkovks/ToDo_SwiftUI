//
// File name: TaskFilter.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 15.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

enum TaskFilter: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    
    case all = "All"
    case completed = "Completed"
    case pending = "Uncompleted"
}
