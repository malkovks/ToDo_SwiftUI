//
// File name: TaskCreateView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

struct TaskCreateView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel: TaskCreateViewModel
    
    init(viewModel: TaskCreateViewModel, onSave: @escaping (_ task: TaskModel) -> Void){
        self.viewModel = viewModel
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
                                FormRowView(title: "") {
                                    RowTextField(placeholder: "Enter name", text: $viewModel.title)
                                    
                                }
                            }
                            SectionView(title: "Category and task priority") {
                                FormRowView(title: "") {
                                    RowTextField(placeholder: "Enter the category", text: $viewModel.category)
                                }
                                FormRowView(title: "Priority") {
                                    MenuRowView(importance: $viewModel.importance)
                                }
                            }
                            
                            SectionView(title: "URL") {
                                FormRowView(title: "") {
                                    RowTextField(placeholder: "Link", text: $viewModel.link)
                                }
                            }
                            
                            SectionView(title: "Dates") {
                                FormRowView(title: "Planned date") {
                                    DatePicker("", selection: $viewModel.plannedDate)
                                        .labelsHidden()
                                        .datePickerStyle(.compact)
                                        .tint(.black)
                                }
                                FormRowView(title: "Reminder") {
                                    Toggle("", isOn: $viewModel.isReminderOn)
                                        .tint(.black)
                                        .onChange(of: viewModel.isReminderOn) { isOn, _ in
                                            viewModel.toggleNotificationAccess(isOn: viewModel.isReminderOn)
                                        }
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
                            
                            
                            
                            SectionView(title: "Photo") {
                                FormRowView(title: "Add Photo") {
                                    
                                    Toggle("", isOn: $viewModel.isPhotoOn)
                                        .onChange(of: viewModel.isPhotoOn) { isOn, _ in
                                            viewModel.togglePhotoAccess(isOn: viewModel.isPhotoOn)
                                        }
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
                            
                            SectionView(title: "Calendar") {
                                FormRowView(title: "Add task to Calendar") {
                                    HStack(alignment: .center, spacing: 10) {
                                        Toggle("", isOn: $viewModel.isAddToCalendar)
                                            .tint(.black)
                                            .onChange(of: viewModel.isAddToCalendar) { isOn, _ in
                                                viewModel.toggleCalendarAccess(isOn: isOn)
                                            }
                                        Button {
                                            viewModel.showsSavingToCalendar = true
                                        } label: {
                                            Image(systemName: "info.circle")
                                                .tint(.black)
                                                .imageScale(.medium)
                                        }
                                    }
                                }
                            }
                        }
                        HStack(spacing: 20) {
                            Button {
                                saveNewTask()
                            } label: {
                                Label("Save New Task", systemImage: "plus.circle.fill")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .tint(.silver)
                            }
                            
                            
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.roundedRectangle(radius: 12))
                            .padding(12)
                            .foregroundStyle(.aqua)
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                viewModel.isDirty ? (viewModel.showUnsavedChangesAlert.toggle()) : dismiss()
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
                        Button("Leave anyway", role: .destructive) {
                            dismiss()
                        }
                        Button("Cancel", role: .cancel) {}
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
                    .sheet(isPresented: $viewModel.showsSavingToCalendar) {
                        InformationView()
                            .presentationDetents([.fraction(0.3)])
                            .presentationCornerRadius(15)
                            .presentationDragIndicator(.visible)
                    }
                    .alert("Enter the name for task if you want to save it", isPresented: $viewModel.showEmptyTitleAlert, actions: {
                        Button("OK", role: .cancel) {}
                    })
                    
                    .alert("Access for Photo denied. Need to allow access in settings", isPresented: $viewModel.showPhotoAlert) {
                        Button("Go to settings") {
                            viewModel.openSettings()
                        }
                        Button("Cancel",role: .cancel) {}
                    }
                    
                    .alert("Access for Notification denied. Need to allow access in settings", isPresented: $viewModel.showNotificationAlert) {
                        Button("Go to settings") {
                            viewModel.openSettings()
                        }
                        Button("Cancel",role: .cancel) {}
                    }
                    
                    .alert("Access for Calendar denied. Need to allow access in settings", isPresented: $viewModel.showEventAlert) {
                        Button("Go to settings") {
                            viewModel.openSettings()
                        }
                        Button("Cancel",role: .cancel) {}
                    }
                }
            }
        }
    }
    
    private func saveNewTask(){
        if viewModel.title.isEmpty {
            viewModel.showEmptyTitleAlert = true
        } else {
            onSave(viewModel.createNewTask())
            viewModel.addTaskToEvent()
            viewModel.scheduleNotificationIfNeeded()
            dismiss()
        }
    }
    
}


struct CalendarToggleView: View {
    @Binding var isShowCalendar: Bool
    @Binding var isSelectedInfo: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Toggle("", isOn: $isShowCalendar)
                .labelsHidden()
                .tint(.black)
            Button {
                isSelectedInfo.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .tint(.black)
                    .imageScale(.medium)
            }
        }
    }
}


#Preview {
    let viewModel = TaskCreateViewModel()
    TaskCreateView(viewModel: viewModel,onSave: { _ in })
}
