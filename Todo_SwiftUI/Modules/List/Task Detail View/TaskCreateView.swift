//
// File name: TaskCreateView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

struct TaskCreateView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = TaskCreateViewModel()
    
    var onSave: (_ task: TaskModel) -> Void
    
    private let column = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                GradientBackgroundView()
                VStack {
                    TitleName(name: "New Task")
                    ScrollView {
                        LazyVGrid(columns: column, spacing: 16) {
                            SectionView(title: "TaskName") {
                                FormRowView(title: "Enter name") {
                                    RowTextField(placeholder: "Enter name", text: $viewModel.title)
                                        
                                }
                            }
                            SectionView(title: "Category and task priority") {
                                FormRowView(title: "Category") {
                                    RowTextField(placeholder: "Enter the category", text: $viewModel.category)
                                }
                                FormRowView(title: "Priority") {
                                    MenuRowView(importance: $viewModel.importance)
                                }
                            }
                            
                            SectionView(title: "Dates") {
                                FormRowView(title: "Planned date") {
                                    DatePicker("", selection: $viewModel.plannedDate,displayedComponents: .date)
                                        .labelsHidden()
                                        .datePickerStyle(.compact)
                                        .tint(.black)
                                }
                                FormRowView(title: "Reminder") {
                                    Toggle("", isOn: $viewModel.isReminderOn)
                                        .labelsHidden()
                                        .tint(.black)
                                }
                                if viewModel.isReminderOn {
                                    withAnimation(.easeInOut(duration: 2)) {
                                        FormRowView(title: "Date Reminder") {
                                            DatePicker("", selection: $viewModel.reminderDate,displayedComponents: .date)
                                                .labelsHidden()
                                                .datePickerStyle(.compact)
                                                .tint(.black)
                                        }
                                    }
                                }
                            }
                            
                            SectionView(title: "Photo") {
                                FormRowView(title: "Add Photo") {
                                    Toggle("", isOn: $viewModel.isPhotoOn)
                                        .labelsHidden()
                                        .tint(.black)
                                }
                                if viewModel.isPhotoOn {
                                    withAnimation(.easeInOut(duration: 2)) {
                                        FormRowView(title: "Choose Photo") {
                                            Button {
                                                viewModel.showPhotoPicker = true
                                            } label: {
                                                Image(systemName: "photo.on.rectangle.fill")
                                                    .tint(.black)
                                            }
                                        }
                                    }
                                }
                                FormImageView(image: viewModel.selectedImage)
                            }
                        }
                        Button {
                            onSave(viewModel.createNewTask())
                            dismiss()
                        } label: {
                            Image(systemName: "trash")
                        }
                        .frame(maxWidth: .infinity,alignment: .center)
                        .padding(.vertical,12)
                        .padding(.horizontal,12)
                        .background(Color.red)
                        

                    }
                    .sheet(isPresented: $viewModel.showPhotoPicker) {
                        PhotoPickerView(selectedImage: $viewModel.selectedImage)
                    }
                }
            }
        }
    }
}

struct FormImageView: View {
    var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .clipShape(.rect(cornerRadius: 12))
                .padding(.bottom, 12)
        }
    }
}

#Preview {
    TaskCreateView { task in
        print(task)
    }
}
