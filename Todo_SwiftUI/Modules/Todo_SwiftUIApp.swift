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

    var body: some Scene {
        WindowGroup {
            LoaderView()
                .colorScheme(.dark)
        }
    }
}
