//
// File name: RowTextField.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 10.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.

import SwiftUI

struct RowTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var isButtonHidden: Bool = false {
        didSet {
            isButtonHidden = text.isEmpty
        }
    }
    
    var body: some View {
        HStack {
            VStack {
                TextField(placeholder, text: $text)
                    .font(.title3)
                    .foregroundColor(.text)
                    .tint(.text)
                    .multilineTextAlignment(.trailing)
                    .padding(.horizontal)
                    .keyboardType(.asciiCapable)
                    .autocorrectionDisabled(true)
                    .submitLabel(.continue)
                    .textInputAutocapitalization(.never)
                Rectangle()
                    .frame(height: 1)
                    .padding(.horizontal,10)
            }
            if !text.isEmpty {
                Image(systemName: "delete.left")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        text.removeAll()
                    }
                .padding(.trailing,10)
            }
        }
        
    }
}

#Preview {
    RowTextField(placeholder: "Placeholder", text: .constant("sd"))
}
