//
// File name: TabButton.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

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
                .font(.system(size: selectedTab == tab ? 18 : 16,weight: .semibold))
                .imageScale(.medium)
                .foregroundStyle(selectedTab == tab ? .white : .white.opacity(0.7))
                .frame(width: 35, height: 35)
                .padding()
                .background(
                    selectedTab == tab ?
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 40, height: 40)
                        .shadow(color: .text, radius: 5, x: 0, y: 3)
                    : nil
                    )
                .scaleEffect(selectedTab == tab ? 1.2 : 1)
        }
        .buttonStyle(.plain)
    }
}
