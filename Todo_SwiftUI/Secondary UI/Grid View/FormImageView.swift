//
// File name: FormImageView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 10.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct FormImageView: View {
    var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .clipShape(.rect(cornerRadius: 12))
                .padding(.bottom, 12)
        }
    }
}
