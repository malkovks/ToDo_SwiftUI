//
// File name: SortingType.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 16.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI


enum SortingType: String, CaseIterable {
    
    case byCreationDateAssending
    case byCreationDateDescending
    case byNotificationDateAssending
    case byNotificationDateDescending
    case byImportance
    
    var title: String {
        switch self {
        case .byCreationDateAssending:
            return "By Date assending"
        case .byCreationDateDescending:
            return "By Date descending"
        case .byNotificationDateAssending:
            return "By Notification date assending"
        case .byNotificationDateDescending:
            return "By Notification date descending"
        case .byImportance:
            return "By Importance"
        }
    }
}
