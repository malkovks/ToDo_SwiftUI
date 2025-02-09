//
// File name: LoaderIndicatorView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 08.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct LoaderIndicatorView: View {
    var progress: Double
    var lineWidth: CGFloat = 10
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(progress) / 100)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [.aqua,.ocean,.midnight,.ocean, .aqua]), center: .center),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            Text("\(Int(progress))%")
                .foregroundStyle(.aqua)
                .bold()
                .font(.headline)
        }
        .frame(width: 120, height: 120, alignment: .center)
        .animation(.easeInOut(duration: 0.01),value: progress)
    }
}
