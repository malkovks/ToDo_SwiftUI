//
// File name: TaskPriorityData.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 18.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct TaskPriorityData: Identifiable {
    let id = UUID()
    let title: TaskImportance
    let color: Color
    let count: Int
}
