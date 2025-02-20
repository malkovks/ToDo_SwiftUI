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
        LinearGradient(colors: [.text.opacity(1),.text.opacity(0.8),.text.opacity(0.6),.text.opacity(0.4),.text.opacity(0.2),.clear], startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}

struct GradientBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.iron.ignoresSafeArea(.all)
            LinearGradient(colors: [.text.opacity(1),.text.opacity(0.8),.text.opacity(0.6),.text.opacity(0.4),.text.opacity(0.2),.clear], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            content
        }
    }
}
