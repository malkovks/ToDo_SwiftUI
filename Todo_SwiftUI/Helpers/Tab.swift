//
// File name: Tab.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.



enum Tab: CaseIterable {
    case tasks
    case statistics
    case settings
    
    var icon: String {
        switch self {
        case .tasks:
            return "list.bullet"
        case .statistics:
            return "chart.pie.fill"
        case .settings:
            return "gearshape"
        }
    }
}