//
// File name: LoaderViewModel.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 08.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

class LoaderViewModel: ObservableObject {
    @Published var progress: Double = 0.0
    @Published var isActive: Bool = false
    private var timer: Timer?
    
    func startLoading(completion: @escaping () -> Void){
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            if self.progress < 100 {
                withTransaction(Transaction(animation: .easeInOut(duration: 0.01))) {
                    self.progress += 1
                }
            } else {
                timer.invalidate()
                completion()
            }
        }
    }
    
    func presentTabView(completion: @escaping () -> Void){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            completion()
        })
    }
}
