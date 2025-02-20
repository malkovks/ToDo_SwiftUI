//
// File name: SettingsView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    
    @AppStorage("notificationSound") var notificationSound: String = "Default"
    @AppStorage("notificationEnabled") var notificationEnabled: Bool = true
    @AppStorage("appBackground") var appBackground: String = "Light"
    @AppStorage("fontSize") var fontSize: Double = 14
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                GradientBackgroundView()
                Form {
                    Section(header: Text("Notifications")) {
                        Toggle("Turn on notifications",isOn: $notificationEnabled)
                            .foregroundStyle(.text)
                            .tint(.text)
                        Picker("Sound", selection: $notificationSound) {
                            Text("Default").tag("Default")
                            Text("Sound 1").tag("Sound 1")
                            Text("Sound 2").tag("Sound 2")
                            Text("Sound 3").tag("Sound 3")
                            Text("Sound 4").tag("Sound 4")
                        }
                        .disabled(!notificationEnabled)
                        .foregroundStyle(.text)
                    }
                    
                    Section(header: Text("Appearance")) {
                        HStack {
                            Text("App mode")
                                .foregroundStyle(.text)
                            Picker("App mode",selection: $appBackground) {
                                Text("Light").tag("Light")
                                Text("Dark").tag("Dark")
                                Text("Custom").tag("Custom")
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    
                    Section(header: Text("Information")) {
                        NavigationLink(destination: AboutView()) {
                            HStack() {
                                Text("About")
                                    .foregroundStyle(.text)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity)
                        }
                        
                    }
                    
                }
                .formStyle(.grouped)
                .foregroundStyle(.silver)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct AboutView: View {
    var body: some View {
        VStack(alignment: .center,spacing: 10) {
            Text("ToDo App v1.0")
                .font(.headline)
            Text("This app was made for educational purposes only. It is not intended to be used in any real-world applications. It is provided as a learning tool.")
            Text("Made by:")
            Text("Malkov Konstantin")
        }
        .padding(.all, 20)
        .navigationTitle("About App")
    }
}

#Preview {
    SettingsView()
}
