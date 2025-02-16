//
// File name: GraphInformationView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 16.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct GraphInformationView: View {
    var viewModel: StatisticsViewModel
    
    init(_ viewModel: StatisticsViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size.width - 32
            VStack(spacing: 16) {
                ZStack {
                    Circle()
                        .stroke(Color.ocean.opacity(0.3), lineWidth: 30)
                    Circle()
                        .trim(from: 0, to: CGFloat(viewModel.completedPercent))
                        .stroke(Color.aqua, lineWidth: 30)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut, value: viewModel.completedPercent)
                    Text(String(format: "%.0f%%", viewModel.completedPercent * 100))
                        .font(.largeTitle)
                        .bold()
                    
                }
                .padding(.all, 16)
                VStack(alignment: .leading,spacing: 8) {
                    Text("Completed: \(Int(viewModel.completedTasks))")
                    Text("Pendings: \(Int(viewModel.pendingTasks))")
                }
                .font(.headline)
            }
            .frame(width: size, height: size,alignment: .center)
        }
        
        .padding()
    }
}
