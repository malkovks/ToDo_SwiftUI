//
// File name: StatisticsView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

struct StatisticsView: View {
    var body: some View {
        ZStack(alignment: .center) {
            GradientBackgroundView()
            Text("Statistics View")
                .foregroundStyle(.iron)
        }
    }
}

#Preview {
    StatisticsView()
}
