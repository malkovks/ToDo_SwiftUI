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
            TextField(placeholder, text: $text)
                .font(.title2)
                .foregroundColor(.black)
                .tint(.black)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled(true)
                .submitLabel(.continue)
                .textInputAutocapitalization(.never)
            if !text.isEmpty {
                Image(systemName: "delete.left")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        text.removeLast()
                    }
                .padding(.trailing,10)
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray,lineWidth: 1)
        }
    }
}

#Preview {
    RowTextField(placeholder: "Placeholder", text: .constant("sd"))
}
