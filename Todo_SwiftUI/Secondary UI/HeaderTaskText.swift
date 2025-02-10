//
// File name: HeaderTaskText.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 10.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct HeaderTaskText: View {
    var text: String
    
    var body: some View {
        Text(text.capitalized)
            .foregroundStyle(.silver)
            .padding(.leading,8)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
