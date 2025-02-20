//
// File name: StatisticsView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

enum StatisticsPeriod: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case allTime = "All time"
    case lastYear = "Last year"
    case lastMonth = "Last month"
}

struct StatisticsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: StatisticsViewModel
    @State private var buttonPosition: CGRect = .zero
    
    init (_ viewModel: StatisticsViewModel) {
        self.viewModel = viewModel
        customSegmentControl()
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack {
                    TitleName(name: "Statistics")
                    if viewModel.totalTasks.isZero {
                        AlertView("There is no tasks to display")
                    } else {
                        ScrollView(.vertical) {
                            VStack {
                                StatisticsSegmentView(viewModel: $viewModel)
                                GraphInformationView(viewModel)
//                                if !viewModel.loadPriorityData().isEmpty {
//                                    PriorityChartView(data: viewModel.loadPriorityData())
//                                }
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.loadStatistics()
                }
            }
            .toolbarVisibility(.hidden, for: .tabBar)
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("settings for graph")
                    } label: {
                        Image(systemName: "gear")
                    }
                    .opacity(viewModel.totalTasks.isZero ? 0 : 1)
                }
            }
            
            .frame(maxWidth: .infinity,alignment: .top)
            .foregroundStyle(.silver)
            .gradientBackground()
        }
    }
}

struct PieChartView: View {
    let data: [TaskPriorityData]

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let total = data.reduce(0) { $0 + $1.count }
            
            ZStack {
                ForEach(data.indices, id: \.self) { index in
                    let previousCount = data.prefix(index).reduce(0) { $0 + $1.count }
                    let startFraction = total > 0 ? Double(previousCount) / Double(total) : 0
                    let currentFraction = total > 0 ? Double(data[index].count) / Double(total) : 0
                    
                    let startAngle = Angle.degrees(-90) + .degrees(360 * startFraction)
                    let endAngle = startAngle + .degrees(360 * currentFraction)
                    
                    Path { path in
                        let center = CGPoint(x: size / 2, y: size / 2)
                        path.move(to: center)
                        path.addArc(
                            center: center,
                            radius: size / 2,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: false
                        )
                    }
                    .fill(data[index].color)
                }
            }
            .frame(width: size, height: size)
        }
    }
}


struct PriorityChartView: View {
    let data: [TaskPriorityData]
    
    var body: some View {
        VStack {
            PieChartView(data: data)
                .frame(height: 200)
            VStack(alignment: .leading,spacing: 8) {
                ForEach(data) { segment in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(segment.color)
                            .frame(width: 12, height: 12)
                        Text("\(segment.title.rawValue.capitalized) - \(segment.color) tasks")
                            .font(.callout)
                    }
                }
            }
            .padding(.top, 8)
        }
    }
}

#Preview {
    PriorityChartView(data: [TaskPriorityData(title: .high, color: .red, count: 2)])
}






