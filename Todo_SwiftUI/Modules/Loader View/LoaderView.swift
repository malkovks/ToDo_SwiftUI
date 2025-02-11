//
// File name: LoaderView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 08.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

import UIKit

struct LoaderView: View {
    @StateObject private var viewModel: LoaderViewModel = .init()
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
            
            if viewModel.isActive {
                MainTabView()
                    .transition(.opacity.combined(with: .scale))
                    .animation(.easeInOut(duration: 1.0), value: viewModel.isActive)
            } else {
                LoaderIndicatorView(progress: viewModel.progress)
                    .onAppear {
                        viewModel.startLoading {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                viewModel.isActive = true
                            }
                            let generator = UIImpactFeedbackGenerator(style: .soft)
                            generator.impactOccurred()
                        }
                    }
            }
        }
    }
}



#Preview {
    return LoaderView()
}


