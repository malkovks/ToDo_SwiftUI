//
// File name: MainTabView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 08.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI
import SwiftData

enum Tab {
    case tasks
    case statistics
    case settings
    
    var icon: String {
        switch self {
        case .tasks:
            return "list.bullet"
        case .statistics:
            return "chart.pie.bar"
        case .settings:
            return "gearshape"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .tasks
    
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
                TasksView().tag(Tab.tasks)
                StatisticsView().tag(Tab.statistics)
                SettingsView().tag(Tab.settings)
            }
            .ignoresSafeArea(.keyboard,edges: .bottom)
            .modelContainer(sharedModelContainer)
        })
    }
}

#Preview {
    return MainTabView()
}

struct TabButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0)) {
                selectedTab = tab
            }
        } label: {
            Image(systemName: tab.icon)
                .font(.system(size: selectedTab == tab ? 24 : 20,weight: .bold))
                .foregroundStyle(selectedTab == tab ? .white : .white.opacity(0.7))
                .padding()
                .background(
                    selectedTab == tab ?
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .scaleEffect(1.1)
                        .shadow(color: .black, radius: 5, x: 0, y: 3)
                    : nil
                    )
                .scaleEffect(selectedTab == tab ? 1.2 : 1)
                    
        }
    }
}
