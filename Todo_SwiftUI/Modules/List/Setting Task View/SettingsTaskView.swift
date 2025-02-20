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
                GradientBackgroundView()
                VStack {
                    
                        Form {
                            Section(header: SettingsSectionHeaderView("Columns count"),
                                    footer: SettingsSectionHeaderView(" Minimum 1, Maximum 4",opacity: 0.5)) {
                                Stepper("Columns count \(columnsCount)",value: $columnsCount, in: 1...4)
                            }
                            if columnsCount > 1 {
                                Section(header: SettingsSectionHeaderView("Spacing between columns"),
                                        footer: SettingsSectionHeaderView(" Minimum 1, Maximum 30",opacity: 0.5)) {
                                    Text("Spacing between columns is \(Int(spacingSize))")
                                    Slider(value: $spacingSize, in: 1...30, step: 1)
                                        .tint(.text)
                                        
                                }
                            }
                            
                            Section(header: SettingsSectionHeaderView("Sorting Type")) {
                                Toggle("Sorting enabled", isOn: $isSortingEnabled)
                                    .tint(.text)
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
                        
                        .listRowSeparator(.hidden)
                        .padding(.horizontal, 10)
                        .background(Color.clear)
                        .scrollContentBackground(.hidden)
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
