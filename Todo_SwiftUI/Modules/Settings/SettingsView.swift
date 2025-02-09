//
// File name: SettingsView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack(alignment: .center) {
            GradientBackgroundView()
            Text("Settings View")
                .foregroundStyle(.iron)
        }
    }
}

#Preview {
    SettingsView()
}
