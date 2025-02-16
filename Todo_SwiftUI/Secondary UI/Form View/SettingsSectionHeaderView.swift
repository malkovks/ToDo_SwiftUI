//
// File name: SettingsSectionHeaderView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 16.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct SettingsSectionHeaderView: View {
    var title: String
    var opacity: Double
    
    init(_ title: String, opacity: Double = 1) {
        self.title = title
        self.opacity = opacity
    }
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .foregroundColor(.silver)
            .opacity(opacity)
    }
}
