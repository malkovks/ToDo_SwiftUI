//
// File name: SettingsTaskView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 15.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

struct SettingsTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var columnsCount: Int
    @Binding var spacingSize: CGFloat
    @Binding var isSortingEnabled: Bool
    @Binding var sortingType: SortingType
    @State private var showReturnToDefault: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack {
                    
                    Form {
                        Section(header: Text("Columns count"),footer: Text(" Minimum 1, Maximum 4")) {
                            Stepper("Columns count \(columnsCount)",value: $columnsCount, in: 1...4)
                        }
                        if columnsCount > 1 {
                            Section(header: Text("Spacing between columns"),footer: Text(" Minimum 1, Maximum 30")) {
                                Slider(value: $spacingSize, in: 1...30, step: 1)
                            }
                        }
                        
                        Section(header: Text("Sorting Type")) {
                            Toggle("Sorting enabled", isOn: $isSortingEnabled)
                                .tint(.black)
                            if isSortingEnabled {
                                Picker("Sorting", selection: $sortingType) {
                                    ForEach(SortingType.allCases, id: \.self) { type in
                                        Text(type.title.capitalized)
                                    }
                                }
                            }
                        }
                        Button {
                            showReturnToDefault = true
                        } label: {
                            Label("Reset to default", systemImage: "arrow.clockwise.circle")
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.down")
                        .tint(.silver)
                }

            }
        }
        .toolbarVisibility(.visible, for: .navigationBar)
        .toolbarRole(.navigationStack)
        .navigationTitle("Settings Task View")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showReturnToDefault) {
            Alert(title: Text("Warning"),
                  message: Text("Do you want to return to default configurations?"),
                  primaryButton: .default(Text("Drop to default"), action: {
                columnsCount = (2)
                spacingSize = (16)
                isSortingEnabled = (false)
                sortingType = .byCreationDateAssending
                dismiss()
            }),
                  secondaryButton: .cancel())
        }
    }
}

#Preview {
    SettingsTaskView(columnsCount: .constant(2),spacingSize: .constant(10), isSortingEnabled: .constant(true), sortingType: .constant(.byCreationDateAssending))
}
