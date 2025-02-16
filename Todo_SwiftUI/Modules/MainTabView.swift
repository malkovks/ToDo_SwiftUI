//
// File name: MainTabView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 08.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI
import SwiftData



struct MainTabView: View {
    @State private var selectedTab: Tab = .tasks
    @State private var isTabBarVisible: Bool = true
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Item.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        return try! ModelContainer(for: schema, configurations: [modelConfiguration])
    }()
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            TabView(selection: $selectedTab) {
                TasksView(viewModel: TasksViewModel(sharedModelContainer.mainContext)/*, isTabBarVisible: $isTabBarVisible*/).tag(Tab.tasks)
                StatisticsView(StatisticsViewModel(context: sharedModelContainer.mainContext)).tag(Tab.statistics)
                SettingsView().tag(Tab.settings)
            }
            .modelContainer(sharedModelContainer)
            
            if isTabBarVisible {
                
                
                HStack(spacing: 40) {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        TabButton(tab: tab, selectedTab: $selectedTab)
                    }
                }
                .padding(.horizontal,20)
                .background(.ocean)
                .clipShape(Capsule())
            }
            
            
        })
        .ignoresSafeArea(.keyboard,edges: .bottom)
        .modelContainer(sharedModelContainer)
        
    }
}

#Preview {
    return MainTabView()
}
