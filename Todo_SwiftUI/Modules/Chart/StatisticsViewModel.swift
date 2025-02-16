//
// File name: StatisticsViewModel.swift
// Package: Todo_SwiftUI
//
// Created by Malkov Konstantin on 16.02.2025.
// Copyright (c) 2024 Malkov Konstantin . All rights reserved.


import SwiftUI
import SwiftData

@Observable
class StatisticsViewModel: ObservableObject {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        loadStatistics()
    }
    
    var showFilter: Bool = false
    var selectedPriority: TaskImportance?
    
    var selectedPeriod: StatisticsPeriod = .allTime
    var completedTasks: Double = 0
    var pendingTasks: Double = 0
    
    var totalTasks: Double {
        completedTasks + pendingTasks
    }
    
    var completedPercent: Double {
        totalTasks > 0 ? completedTasks / totalTasks : 0
    }
    
    func loadStatistics(){
        do {
            let fetchResult = try context.fetch(FetchDescriptor<Item>())
            completedTasks = Double(fetchResult.filter(\.isCompleted).count)
            pendingTasks = Double(fetchResult.filter({ !$0.isCompleted }).count)
        } catch {
            print("Cant load Items count")
        }
    }
    
    func sortByPriority(_ taskPriority: TaskImportance?){
        do {
            var fetchDescriptor = FetchDescriptor<Item>()
            if let taskPriority = taskPriority {
                let priority = taskPriority.rawValue.capitalized
                fetchDescriptor.predicate = #Predicate<Item> { item in
                    item.importance == priority
                }
            }
            let fetchResult = try context.fetch(fetchDescriptor)
            DispatchQueue.main.async { [self] in
                completedTasks = Double(fetchResult.filter(\.isCompleted).count)
                pendingTasks = Double(fetchResult.filter({ !$0.isCompleted }).count)
            }
        } catch {
            print("Cant load Items count for sorting priority")
        }
    }
    
    func filterByPeriod(_ period: StatisticsPeriod) {
        let now = Date()
        let calendar = Calendar.current
        var startDate: Date?
        
        switch period {
        case .allTime:
            startDate = nil
        case .lastYear:
            startDate = calendar.date(byAdding: .year, value: -1, to: now)
        case .lastMonth:
            startDate = calendar.date(byAdding: .month, value: -1, to: now)
        }
        
        do {
            var fetchDescriptor = FetchDescriptor<Item>()
            if let startDate = startDate {
                fetchDescriptor.predicate = #Predicate<Item> { item in
                    item.creationDate >= startDate
                }
            }
            let fetchResult = try context.fetch(fetchDescriptor)
            DispatchQueue.main.async {
                self.completedTasks = Double(fetchResult.filter(\.isCompleted).count)
                self.pendingTasks = Double(fetchResult.filter { !$0.isCompleted }.count)
                print("Data refresh for statistics \(period.rawValue)")
            }
        } catch {
            print("Can't load Items count: \(error)")
        }
    }
}
