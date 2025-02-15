//
// File name: TaskImportance.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

enum TaskImportance: String,CaseIterable {
    var id: Self { self }
    
    case high, medium, low
    
    init?(rawValue: String) {
        switch rawValue {
        case "High":
            self = .high
        case "Medium":
            self = .medium
        case "Low":
            self = .low
        default:
            return nil
        }
    }
    
    var color: Color {
        switch self {
        case .high:
            return .red
        case .medium:
            return .yellow
        case .low:
            return .green
        }
    }
    
    var title: String {
        switch self {
        case .high:
            return "High"
        case .medium:
            return "Medium"
        case .low:
            return "Low"
        }
    }
    
    var imagePriority: String {
        switch self {
        case .high:
            return "exclamationmark.3"
        case .medium:
            return "exclamationmark.2"
        case .low:
            return "exclamationmark"
        }
    }
    
    var tagImpornance: Int {
        switch self {
        case .high:
            return 2
        case .medium:
            return 1
        case .low:
            return 0
        }
    }
}
