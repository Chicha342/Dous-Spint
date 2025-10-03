//
//  HistoryView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var settings: ViewModel
    @Environment(\.colorScheme) var systemScheme
    
    @State private var selectedStatus: String = "All"
    @State private var selectedCategory: String = "All"
    @State private var selectedTask: TaskItem? = nil
    
    @State private var selectedResult: SpinResult? = nil
    
    @State private var showTaskDetails: Bool = false
    
    private let statusFilters = ["All", "Completed", "Skipped"]
    private let categoryFilters = ["All", "Body", "Mind", "Soul", "Connect", "Create"]
    
    private var filteredResults: [SpinResult] {
        let historyResults = settings.spinResults
            .filter { $0.status == .completed || $0.status == .skipped }
            .sorted { ($0.completedAt ?? $0.date) > ($1.completedAt ?? $1.date) }
        
        return historyResults.filter { result in
            let statusMatch = selectedStatus == "All" ||
            (selectedStatus == "Completed" && result.status == .completed) ||
            (selectedStatus == "Skipped" && result.status == .skipped)
            
            guard let task = settings.allTasks.first(where: { $0.id == result.taskId }) else {
                return false
            }
            
            let categoryMatch = selectedCategory == "All" || task.category == selectedCategory
            
            return statusMatch && categoryMatch
        }
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(settings.backgroundColor)
                .ignoresSafeArea(edges: .all)
            VStack(){
                Text("History")
                    .font(.calistoga(size: 24))
                    .foregroundColor(settings.headerTextColor)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top)
                
                HStack(alignment: .top, spacing: 12) {
                    DropdownFilter(title: "Category", options: categoryFilters, selection: $selectedCategory)
                    DropdownFilter(title: "Status", options: statusFilters, selection: $selectedStatus)
                }
                .padding(.horizontal)
                .padding(.top)
                
                if filteredResults.isEmpty {
                    Spacer()
                    HStack(spacing: 6){
                        Image("timeImage")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("No history yet.")
                            .font(.poppins(.medium, size: 20))
                    }
                    .foregroundColor(customColor())
                    
                }else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredResults) { result in
                                if let task = settings.allTasks.first(where: { $0.id == result.taskId }) {
                                    HistoryContainer(result: result, task: task)
                                        .onTapGesture {
                                            selectedTask = task
                                            selectedResult = result
                                        }
                                }
                            }
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 16)
                    }
                }
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: Binding(
            get: { selectedTask != nil && selectedResult != nil },
            set: {
                if !$0 {
                    selectedTask = nil
                    selectedResult = nil
                }
            }
        )) {
            if let task = selectedTask, let result = selectedResult {
                HistoryDetails(result: result, task: task)
                    .environmentObject(settings)
            }
        }
    }
    
    private func customColor() -> Color {
        switch settings.selectedTheme {
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 151, g: 53, b: 194)) :
                UIColor(Color(r: 76, g: 76, b: 76))
            })
        case .light:
            return .init(r: 76, g: 76, b: 76)
        case .dark:
            return .init(r: 151, g: 53, b: 194)
        }
    }
    
}

#Preview {
    HistoryView()
        .environmentObject(ViewModel())
        .colorScheme(.light)
}

#Preview {
    HistoryView()
        .environmentObject(ViewModel())
        .colorScheme(.dark)
}
