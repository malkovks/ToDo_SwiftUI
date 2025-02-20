//
// File name: InfoView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 13.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct InformationView: View {
    var body: some View {
        ZStack {
            Text("This function appears you to add created task into your Calendar application it it necessary")
                .font(.largeTitle)
                .foregroundStyle(.text)
                .padding(.horizontal, 10)
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.thinMaterial)
    }
}
