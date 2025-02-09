//
// File name: TasksView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

struct TasksView: View {
    @StateObject private var viewModel = TasksViewModel()
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(),spacing: 16), count: 2)
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                GradientBackgroundView()
                VStack(spacing: 10) {
                    Text("Tasks")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.silver)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top,10)
                    
                    if viewModel.tasks.isEmpty {
                        Text("Press + to add new items")
                            .font(.title)
                            .foregroundStyle(.silver)
                        
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns,spacing: 16) {
                                ForEach(viewModel.tasks) { task in
                                    TaskCell(task: task, isEditing: viewModel.isEditing, isSelected: viewModel.selectedTasks.contains(task.id)) {
                                        viewModel.toggleTaskSelection(task.id)
                                    } completionAction: {
                                        viewModel.completeTask(task.id)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation(.bouncy) {
                            viewModel.isEditing.toggle()
                        }
                    } label: {
                        Image(systemName: viewModel.isEditing ? "checkmark.circle" : "pencil.circle")
                            .font(.title.bold())
                            .foregroundStyle(.silver)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.horizontal)
                    }
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //Добавить  ссылку на следующий контроллер для создания новой задачи
//                        viewModel.addTask()
                        viewModel.isEditing ? viewModel.deleteTasks() : viewModel.showingAlert.toggle()
                    } label: {
                        Image(systemName: viewModel.isEditing ? "trash" : "plus")
                            .tint(viewModel.isEditing ? .red : .silver)
                            .fontWeight(.medium)
                            .font(.system(size: 24))
                    }
                    .disabled(viewModel.isEditing ? viewModel.selectedTasks.isEmpty : false)

                }
            }
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text("Warning"),
                      message: Text("Do you want to delete selected tasks?"),
                      primaryButton: .destructive(Text("Delete"), action: {
                    viewModel.deleteTasks()
                }),
                      secondaryButton: .cancel(Text("Cancel"), action: {
                    viewModel.showingAlert.toggle()
                    viewModel.isEditing.toggle()
                }))
            }
        }
    }
}



#Preview {
    TasksView()
}
