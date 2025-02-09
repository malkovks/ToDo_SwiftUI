//
// File name: TaskCell.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct TaskCell: View {
    let task: TaskModel
    let isEditing: Bool
    let isSelected: Bool
    let selectionAction: () -> Void
    let completionAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                    .font(.headline)
                    .lineLimit(1)
            
            Text(task.category)
                .font(.subheadline)
                .foregroundStyle(.black)
            Rectangle()
                .frame(height: 6)
                .clipShape(.rect(cornerRadius: 3))
                .foregroundStyle(task.importance.color)
            HStack {
                Spacer()
                Button {
                    completionAction()
                } label: {
                    Circle()
                        .stroke(task.isCompleted ? .green : .iron,lineWidth: 2)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Circle()
                                .fill(task.isCompleted ? .green : .iron)
                                .padding(4)
                        }
                }

            }
        }
        .padding()
        .background(isSelected ? .aqua : .silver).opacity(0.8)
        .clipShape(.rect(cornerRadius: 12))
        .overlay(alignment: .topTrailing) {
            if isEditing {
                Button(action: selectionAction) {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(isSelected ? .yellow : .red)
                        .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                }
            }
        }
    }
}
