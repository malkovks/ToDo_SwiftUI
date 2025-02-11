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
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            TabView(selection: $selectedTab) {
                TasksView(isTabBarVisible: $isTabBarVisible).tag(Tab.tasks)
                StatisticsView().tag(Tab.statistics)
                SettingsView().tag(Tab.settings)
            }
            
            if isTabBarVisible {
                
                
                HStack(spacing: 40) {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        TabButton(tab: tab, selectedTab: $selectedTab)
                    }
                }
                .padding(.horizontal,20)
                .padding(.vertical,10)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.midnight,.ocean]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(.capsule)
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                )
                .padding(.bottom,10)
            }
            
            
        })
        .ignoresSafeArea(.keyboard,edges: .bottom)
        .modelContainer(sharedModelContainer)
        
    }
}

#Preview {
    return MainTabView()
}
