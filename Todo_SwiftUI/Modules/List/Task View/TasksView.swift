//
// File name: TasksView.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

struct TasksView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: TasksViewModel
    @Binding var isTabBarVisible: Bool
    
    
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(),spacing: 16), count: 2)
    
    var body: some View {
        NavigationView {
            
            ZStack(alignment: .top) {
                GradientBackgroundView()
                VStack(spacing: 10) {
                    TitleName(name: "Tasks")
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
                                        viewModel.completeTask(with: task.id)
                                    }
                                    .onTapGesture {
                                        viewModel.selectedTask = task
                                        viewModel.showEditTaskCreateView.toggle()
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .toolbarVisibility(.hidden, for: .tabBar)
            .toolbarRole(.editor)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation(.bouncy) {
                            viewModel.isEditing.toggle()
                        }
                    } label: {
                        Image(systemName: viewModel.isEditing ? "checkmark.circle" : "pencil.circle")
                            .fontWeight(.regular)
                            .foregroundStyle(.silver)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding(.horizontal)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isEditing ?  viewModel.showingAlert.toggle() : (viewModel.showTaskCreateView = true)
                        
                    } label: {
                        Image(systemName: viewModel.isEditing ? "trash" : "plus")
                            .tint(viewModel.isEditing ? .red : .silver)
                            .fontWeight(.regular)
                            .font(.system(size: 24))
                    }
                    .disabled(viewModel.isEditing ? viewModel.selectedTasks.isEmpty : false)
                    
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
//            .fullScreenCover(isPresented: $viewModel.showEditTaskCreateView, content: {
//                if let model = viewModel.selectedTask {
//                    TaskCreateView() { task in
//                        viewModel.updateTask(task)
//                    }
//                    .transition(.slide.animation(.easeInOut))
//                }
//            })
            
            .fullScreenCover(isPresented: $viewModel.showTaskCreateView) {
                let viewModel = TaskCreateViewModel()
                TaskCreateView(viewModel: viewModel) { task in
                    self.viewModel.addTask(task)
                }
                .transition(.slide.animation(.easeInOut))
            }
        }
        .onAppear {
            isTabBarVisible = true
        }
    }
}
