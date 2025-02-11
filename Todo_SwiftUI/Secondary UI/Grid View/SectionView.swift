//
// File name: SectionView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 10.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct SectionView<Content: View>: View {
    let content: Content
    let title: String
    
    init(title: String,@ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }
    
    var body: some View {
        HeaderTaskText(text: title)
        VStack(spacing: 0) {
            self.content
        }
        
        .shadow(radius: 8)
        .background(.silver)
        .clipShape(.rect(cornerRadius: 12))
        .padding(.horizontal, 12)
    }
}
