//
// File name: Todo_SwiftUIApp.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 08.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI
import SwiftData

@main
struct Todo_SwiftUIApp: App {
    
    @AppStorage("appBackground") var background: String = "Light"

    var body: some Scene {
        WindowGroup {
            LoaderView()
                .preferredColorScheme(confirmStyle())
        }
    }
    
    private func confirmStyle() -> ColorScheme? {
        switch background{
        case "Light": return .light
        case "Dark" : return .dark
        case "Custom" : return .none
        default:
            return .none
        }
    }
}
