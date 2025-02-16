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
                            StatisticsSegmentView(viewModel: $viewModel)
                            GraphInformationView(viewModel)
                        }
                        
                    }
//                    if viewModel.showFilter {
//                        FilterPopupView(isVisible: $viewModel.showFilter, selectedStatus: $viewModel.selectedPriority) {
//                            viewModel.sortByPriority(viewModel.selectedPriority)
//                            viewModel.showFilter = false
//                        }
//                        .position(x: 200,y: buttonPosition.maxY + 8)
//                        .transition(.move(edge: .top))
//                    }
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
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.showFilter.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .tint(.silver)
                            .fontWeight(.semibold)
                    }
                    .coordinateSpace(name: "navBarContainer")
                    .onPreferenceChange(ButtonPositionKey.self) { newPosition in
                        buttonPosition = newPosition
                    }
                }
            }
            
            .frame(maxWidth: .infinity,alignment: .top)
            .foregroundStyle(.silver)
            .gradientBackground()
        }
    }
}

struct FilterButton: View {
    @Binding var showFilter: Bool
    
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .tint(.silver)
                .fontWeight(.semibold)
        }
        .background(
            GeometryReader { geo in
                Color.clear.preference(key: ButtonPositionKey.self, value: geo.frame(in: .named("navBarContainer")))
            }
        )
    }
}

struct ButtonPositionKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct FilterPopupView: View {
    @Binding var isVisible: Bool
    @Binding var selectedStatus: TaskImportance?
    var applyFilter: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Text("Filter tasks")
                .font(.headline)
                .padding(.top)
            //add property "All prioritets" for default settings
            List {
                ForEach(TaskImportance.allCases, id: \.id) { item in
                    Text(item.rawValue.capitalized)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 4)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedStatus = item
                            applyFilter()
                        }
                }
            }
            .frame(height: 150)

            Button {
                applyFilter()
                isVisible = false
            } label: {
                Text("Apply")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.ocean)
                    .foregroundColor(.silver)
                    .clipShape(Capsule())
            }
        }
        .frame(width: 300)
        .background(VisualEffectView(effect: UIBlurEffect(style: .systemMaterial)))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 10)
        .onTapGesture { }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: effect)
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}







