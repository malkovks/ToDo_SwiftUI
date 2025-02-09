//
// File name: LoaderView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 08.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct LoaderView: View {
    @StateObject private var viewModel: LoaderViewModel = .init()
    
    var body: some View {
        if viewModel.isActive {
            MainTabView()
                .transition(.opacity.combined(with: .scale(0.95, anchor: .center)))
        } else {
            ZStack(alignment: .center, content: {
                GradientBackgroundView()
                LoaderIndicatorView(progress: viewModel.progress)
                .onAppear {
                    viewModel.startLoading {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            viewModel.isActive = true
                        }
                    }
                }
            })
        }
    }
}

struct GradientBackgroundView: View {
    var body: some View {
        Color.iron.ignoresSafeArea(.all)
        LinearGradient(colors: [.black.opacity(1),.black.opacity(0.8),.black.opacity(0.6),.black.opacity(0.4),.black.opacity(0.2),.clear], startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}



#Preview {
    return LoaderView()
}


