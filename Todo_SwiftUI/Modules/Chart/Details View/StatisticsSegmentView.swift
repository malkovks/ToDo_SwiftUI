//
// File name: StatisticsSegmentView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 16.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct StatisticsSegmentView: View {
    @Binding var viewModel: StatisticsViewModel
    
    var body: some View {
        
        Picker("Period", selection: $viewModel.selectedPeriod) {
            ForEach(StatisticsPeriod.allCases, id: \.self) { period in
                Text(period.rawValue)
            }
        }
        
        .pickerStyle(.segmented)
        .padding()
        .onChange(of: viewModel.selectedPeriod) { newPeriod, _ in
            viewModel.filterByPeriod(newPeriod)
        }
    }
}
