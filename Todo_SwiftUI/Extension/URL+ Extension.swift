//
// File name: URL+ Extension.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 16.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI


extension URL {
    func checkValidation() -> Self {
        if !self.absoluteString.isEmpty, self.scheme == nil {
            return URL(string: "https://\(self.absoluteString)")!
        } else {
            return self
        }
    }
}



