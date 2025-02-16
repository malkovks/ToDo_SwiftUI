//
// File name: AlertView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 16.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct AlertView: View {
    var title: String
    
    init(_ title: String){
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.title)
                .foregroundStyle(.silver)
                .frame(maxHeight: .infinity,alignment: .center)
                .padding()
        }
    }
}


