//
// File name: GradientBackgroundView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 11.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
        Color.iron.ignoresSafeArea(.all)
        LinearGradient(colors: [.black.opacity(1),.black.opacity(0.8),.black.opacity(0.6),.black.opacity(0.4),.black.opacity(0.2),.clear], startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}
