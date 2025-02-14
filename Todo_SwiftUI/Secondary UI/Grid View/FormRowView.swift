//
// File name: FormRowView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 10.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI


struct FormRowView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String,@ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        HStack(alignment: .center,spacing: 5) {
            Text(title)
                .foregroundStyle(.black)
                .font(.subheadline)
                .padding(.leading,10)
            Spacer()
            content
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.trailing,10)
        }
        .frame(height: 50)
        
    }
}
