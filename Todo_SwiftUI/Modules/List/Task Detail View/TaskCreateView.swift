//
// File name: TaskCreateView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

struct TaskCreateView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: TaskCreateViewModel
    
    init(taskModel: TaskModel? = nil, onSave: @escaping (_ task: TaskModel) -> Void){
        if let taskModel = taskModel {
            viewModel = TaskCreateViewModel(taskModel: taskModel)
        } else {
            let newTask = TaskModel(title: "", category: "", importance: .medium)
            viewModel = TaskCreateViewModel(taskModel: newTask)
        }
        self.onSave = onSave
    }
    
    var onSave: (_ task: TaskModel) -> Void
    
    private let column = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                GradientBackgroundView()
                
                VStack {
                    
                    ScrollView {
                        TitleName(name: "New Task")
                        LazyVGrid(columns: column, spacing: 16) {
                            SectionView(title: "Task Name") {
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
                                        FormRowView(title: "Reminder date") {
                                            DatePicker("", selection: $viewModel.reminderDate, in: Date()...)
                                                .labelsHidden()
                                                .datePickerStyle(.compact)
                                                .tint(.black)
                                        }
                                    }
                                }
                            }
                            
                            SectionView(title: "URL") {
                                FormRowView(title: "Add Link") {
                                    RowTextField(placeholder: "Link", text: $viewModel.link)
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
                                                viewModel.showTypesImages = true
                                            } label: {
                                                Image(systemName: "photo.on.rectangle.fill")
                                                    .tint(.black)
                                            }
                                        }
                                    }
                                    FormImageView(image: viewModel.selectedImage)
                                }
                                
                            }
                        }
                        HStack(spacing: 20) {
                            Button {
                                onSave(viewModel.createNewTask())
                                dismiss()
                            } label: {
                                Label("Save New Task", systemImage: "plus.circle.fill")
                                    .imageScale(.large)
                                    .tint(.black)
                            }
                            .frame(maxWidth: .infinity,alignment: .center)
                            .frame(height: 50)
                            .background(.silver)
                            .clipShape(.rect(cornerRadius: 12))
                            .padding(12)
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                if viewModel.isDirty {
                                    viewModel.showUnsavedChangesAlert = true
                                } else {
                                    dismiss()
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .tint(.silver)
                                    .imageScale(.large)
                            }
                        }
                    }
                    
                    
                    .fullScreenCover(isPresented: $viewModel.showPhotoPicker) {
                        PhotoPickerView(selectedImage: $viewModel.selectedImage)
                    }
                    .fullScreenCover(isPresented: $viewModel.showCameraController) {
                        CameraPickerView(selectedImage: $viewModel.selectedImage)
                    }
                    .navigationBarBackButtonHidden(true)
                    .alert("You have some unsaved changes. Are you sure you want to leave?", isPresented: $viewModel.showUnsavedChangesAlert) {
                        Button("Cancel", role: .cancel) {}
                        Button("Leave anyway", role: .destructive) {
                            dismiss()
                        }
                    }
                    .confirmationDialog("Select image resource", isPresented: $viewModel.showTypesImages, titleVisibility: .visible) {
                        Button("Camera") {
                            viewModel.showCameraController = true
                        }
                        Button("Photo Library") {
                            viewModel.showPhotoPicker = true
                        }
                        Button("Cancel", role: .cancel) {}
                    }
                }
            }
        }
    }
}



#Preview {
    TaskCreateView(onSave: { _ in })
}
