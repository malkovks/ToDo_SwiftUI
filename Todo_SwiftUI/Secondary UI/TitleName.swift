//
// File name: TitleName.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct TitleName: View {
    let name: String
    
    var body: some View {
        Text(name)
            .font(.largeTitle.bold())
            .foregroundStyle(.silver)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
            .padding(.top,10)
    }
}
