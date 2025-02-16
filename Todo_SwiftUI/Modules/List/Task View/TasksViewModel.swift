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
    var selectedFilter: TaskFilter = .all
    var filteredTasks: [TaskModel] {
        switch selectedFilter {
        case .all:
            return tasks
        case .completed:
            return tasks.filter { $0.isCompleted }
        case .pending:
            return tasks.filter { !$0.isCompleted }
        }
    }
    var isEditing: Bool = false
    var showingAlert: Bool = false
    var selectedTasks: Set<UUID> = []
    var selectedTask: TaskModel?
    var showTaskCreateView: Bool = false
    var showEditTaskCreateView: Bool = false
    var showSettingsTaskView: Bool = false
    
    init(_ modelContext: ModelContext){
        self.modelContext = modelContext
        loadTasks()
    }
    
    func sortTasks(by criteria: SortingType){
        switch criteria {
        case .byCreationDateAssending:
            let _ = filteredTasks.sorted { $0.plannedCompleteDate < $1.plannedCompleteDate }
        case .byCreationDateDescending:
            let _ = filteredTasks.sorted { $0.plannedCompleteDate > $1.plannedCompleteDate }
        case .byNotificationDateAssending:
            let _ = filteredTasks.sorted {
                guard let date1 = $0.notificationDate, let date2 = $1.notificationDate else {
                    return false
                }
                return date1 < date2
            }
        case .byNotificationDateDescending:
            let _ = filteredTasks.sorted {
                guard let date1 = $0.notificationDate, let date2 = $1.notificationDate else {
                    return false
                }
                return date1 > date2
            }
        case .byImportance:
            let _ = filteredTasks.sorted { $0.importance.tagImpornance > $1.importance.tagImpornance }
        }
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
            existedTask.plannedCompleteDate = task.plannedCompleteDate
            existedTask.notificationDate = task.notificationDate
            
            try? modelContext.save()
            self.loadTasks()
        }
    }
    
    func deleteTask(with id: UUID){
        guard let item = try? modelContext.fetch(FetchDescriptor<Item>()).first(where: { $0.id == id }) else { return }
        modelContext.delete(item)
        try? modelContext.save()
        loadTasks()
        print("delete successfully")
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
