//
// File name: View+Extension.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 16.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

extension View {
    func gradientBackground() -> some View {
        self.modifier(GradientBackgroundModifier())
    }
    
    func customSegmentControl() {
        UISegmentedControl.appearance().backgroundColor = .ocean
        UISegmentedControl.appearance().selectedSegmentTintColor = .silver
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.silver)], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.black)], for: .selected)
    }
}
