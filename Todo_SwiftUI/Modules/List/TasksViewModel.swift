//
// File name: Untitled.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI

@Observable
class TasksViewModel: ObservableObject {
    var tasks: [TaskModel] = TaskModel.mockData()
    var isEditing: Bool = false
    var showingAlert: Bool = false
    var selectedTasks: Set<UUID> = []
    
    func toggleTaskSelection(_ id: UUID){
        if selectedTasks.contains(id){
            selectedTasks.remove(id)
        } else {
            selectedTasks.insert(id)
        }
    }
    
    func completeTask(_ id: UUID){
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            withAnimation(.bouncy) {
                self.tasks[index].isCompleted.toggle()
            }
        }
    }
    
    func addTask(with title: String = "New Task",category: String = "Default",priority: TaskImportance = .medium){
        withAnimation(.interactiveSpring) {
            tasks.append(TaskModel(title: title, category: category, importance: priority))
        }
    }
    
    func deleteTasks(){
        
        for task in tasks {
            for selectedTask in selectedTasks {
                if task.id == selectedTask {
                    tasks.removeAll(where: { $0.id == selectedTask })
                }
            }
        }
        withAnimation(.interpolatingSpring) {
            showingAlert = false
            isEditing = false
        }
        
    }
}
