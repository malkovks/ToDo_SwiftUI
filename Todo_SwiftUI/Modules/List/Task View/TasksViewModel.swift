//
// File name: Untitled.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 09.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI
import SwiftData

@Observable
class TasksViewModel: ObservableObject {
    private let modelContext: ModelContext
    
    var tasks: [TaskModel] = []
    var isEditing: Bool = false
    var showingAlert: Bool = false
    var selectedTasks: Set<UUID> = []
    var showTaskCreateView: Bool = false
    
    init(_ modelContext: ModelContext){
        self.modelContext = modelContext
        loadTasks()
    }

    func loadTasks(){
        let fetchDescription = FetchDescriptor<Item>()
        if let item = try? modelContext.fetch(fetchDescription) {
            withAnimation {
                self.tasks = item.map({ TaskModel($0) })
            }
        }
    }
    
    func toggleTaskSelection(_ id: UUID){
        if selectedTasks.contains(id){
            selectedTasks.remove(id)
        } else {
            selectedTasks.insert(id)
        }
    }
    
    func addTask(_ task: TaskModel){
        withAnimation(.bouncy) {
            let item = Item(task)
            modelContext.insert(item)
            try? modelContext.save()
            self.loadTasks()
        }
    }
    
    func updateTask(_ task: TaskModel){
        if let existedTask = try? modelContext.fetch(FetchDescriptor<Item>()).first(where: { $0.id == task.id }){
            existedTask.title = task.title
            existedTask.category = task.category
            existedTask.importance = task.importance.rawValue
            existedTask.isCompleted = task.isCompleted
            existedTask.image = task.image
            existedTask.link = task.link
            existedTask.creationDate = task.creationDate
            existedTask.notificationDate = task.notificationDate
            
            try? modelContext.save()
            self.loadTasks()
        }
    }
    
    func deleteTasks(){
        for selectedTask in selectedTasks {
            if let item = try? modelContext.fetch(FetchDescriptor<Item>()).first(where: { $0.id == selectedTask }) {
                modelContext.delete(item)
            }
        }
        try? modelContext.save()
        withAnimation(.interpolatingSpring) {
            showingAlert = false
            isEditing = false
        }
        loadTasks()
    }
    
    func completeTask(with id: UUID){
        if let index = tasks.firstIndex(where: { $0.id == id }) {
            withAnimation(.bouncy) {
                tasks[index].isCompleted.toggle()
                updateTask(tasks[index])
            }
        }
    }
}
