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
//    @Binding var isTabBarVisible: Bool
    
    @State private var columnsCount: Int = 2
    @State private var spacingSize: CGFloat = 16
    @State private var isSortingEnable: Bool = false
    @State private var sortingType: SortingType = .byCreationDateAssending {
        didSet {
            isSortingEnable ? viewModel.sortTasks(by: sortingType) : ()
        }
    }
    
    init(viewModel: TasksViewModel/*, isTabBarVisible: Binding<Bool>*/) {
        self.viewModel = viewModel
//        self.isTabBarVisible = isTabBarVisible
        customSegmentControl()
    }
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(),spacing: spacingSize), count: columnsCount)
    }
    
    var body: some View {
        NavigationView {
            
            ZStack(alignment: .top) {
                GradientBackgroundView()
                VStack(spacing: 10) {
                    TitleName(name: "Tasks")
                    if viewModel.tasks.isEmpty {
                        AlertView("Press + to add new items")
                    } else {
                        ScrollView {
                            Picker("Filter",selection: $viewModel.selectedFilter) {
                                ForEach(TaskFilter.allCases, id: \.id) { filter in
                                    Text(filter.rawValue).tag(filter)
                                        .foregroundStyle(viewModel.selectedFilter == filter ? .white : .silver)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding()
                            LazyVGrid(columns: columns,spacing: 16) {
                                ForEach(viewModel.filteredTasks) { task in
                                    TaskCell(task: task, isEditing: viewModel.isEditing, isSelected: viewModel.selectedTasks.contains(task.id)) {
                                        viewModel.toggleTaskSelection(task.id)
                                    } completionAction: {
                                        viewModel.completeTask(with: task.id)
                                    }
                                    .contextMenu {
                                        Button {
                                            viewModel.deleteTask(with: task.id)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }

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
                            .tint(.silver)
                            .opacity(viewModel.tasks.isEmpty ? 0 : 1)
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.showSettingsTaskView = true
                    } label: {
                        Image(systemName: "gear.badge")
                            .tint(.silver)
                            .fontWeight(.regular)
                            .opacity(viewModel.filteredTasks.isEmpty ? 0 : 1)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isEditing ?  viewModel.showingAlert.toggle() : (viewModel.showTaskCreateView = true)
                        
                    } label: {
                        Image(systemName: viewModel.isEditing ? "trash" : "plus")
                            .tint(viewModel.isEditing ? .red : .silver)
                            .fontWeight(.regular)
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
            
            .fullScreenCover(isPresented: $viewModel.showSettingsTaskView, content: {
                NavigationView {
                    SettingsTaskView(columnsCount: $columnsCount,spacingSize: $spacingSize, isSortingEnabled: $isSortingEnable, sortingType: $sortingType)
                        .transition(.slide.animation(.easeInOut))
                }
            })
            
            .fullScreenCover(isPresented: $viewModel.showTaskCreateView) {
                let viewModel = TaskCreateViewModel()
                TaskCreateView(viewModel: viewModel) { task in
                    self.viewModel.addTask(task)
                }
                .transition(.slide.animation(.easeInOut))
            }
        }
    }
}
