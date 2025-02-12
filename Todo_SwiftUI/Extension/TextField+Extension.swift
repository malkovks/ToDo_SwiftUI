//
// File name: TextField+Extension.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 12.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

extension View {
    func onUrlChange(_ text: Binding<String>) -> some View {
        self.onChange(of: text.wrappedValue) { newValue, _ in
            if !newValue.isEmpty, let url = URL(string: newValue), url.scheme == nil {
                text.wrappedValue = "https://\(newValue)"
            }
        }
    }
}

extension URL {
    func checkValidation() -> Self {
        if !self.absoluteString.isEmpty, self.scheme == nil {
            return URL(string: "https://\(self.absoluteString)")!
        } else {
            return self
        }
    }
}
