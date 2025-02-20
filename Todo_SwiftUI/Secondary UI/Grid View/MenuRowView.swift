//
// File name: MenuRowView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 10.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct MenuRowView: View {
    @Binding var importance: TaskImportance
    
    var body: some View {
        HStack {
            Menu {
                Picker("", selection: $importance) {
                    ForEach(TaskImportance.allCases, id: \.self) { item in
                        Label {
                            Text(item.title)
                        } icon: {
                            Image(systemName: item.imagePriority)
                        }
                        .tag(item)
                    }
                }
            } label: {
                HStack {
                    Text(importance.title)
                    Image(systemName: "info.circle")
                        .tint(.text)
                        .scaledToFit()
                        .frame(width: 30, height: 30)

                }
                .tint(.text)
                .imageScale(.small)
            }
        }
    }
}
