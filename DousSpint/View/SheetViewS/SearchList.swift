//
//  SearchList.swift
//  DousSpint
//
//  Created by Никита on 03.10.2025.
//

import SwiftUI

struct SearchList: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var systemScheme
    @Environment(\.dismiss) private var dismiss
    
    @State private var isErrorShown: Bool = false
    
    @State private var selectedTask: TaskItem? = nil
    
    private let categoryFilters = ["All", "New", "Difficulty", "Time"]
    @State private var selectedCategory: String = "All"
    
    private var sortedTasks: [TaskItem] {
        switch selectedCategory {
        case "New":
            return viewModel.filteredTasks.sorted { $0.id > $1.id }
        case "Difficulty":
            let difficultyOrder = ["Easy": 1, "Medium": 2, "Hard": 3]
            return viewModel.filteredTasks.sorted {
                (difficultyOrder[$0.difficulty] ?? 0) < (difficultyOrder[$1.difficulty] ?? 0)
            }
        case "Time":
            return viewModel.filteredTasks.sorted { $0.estimatedTime < $1.estimatedTime }
        default:
            return viewModel.filteredTasks
        }
    }
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(viewModel.backgroundColor)
                .ignoresSafeArea()
            
            VStack(){
                HStack(spacing: 14){
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image("arrowBack")
                    })
                    
                    
                    Text("Search")
                        .font(.calistoga(size: 24))
                        .foregroundColor(viewModel.headerTextColor)
                    Spacer()
                }
                
                .padding(.top)
                .padding(.leading)
                
                VStack{
                    
                    if isErrorShown {
                        Spacer()
                        Image("errorImage")
                            .resizable()
                            .frame(width: 30, height: 24)
                        
                        Text("Something went wrong.")
                            .font(.poppins(.regular, size: 16))
                        .foregroundColor(viewModel.buttonTextColor)
                        
                        Text("Please try again!")
                            .font(.poppins(.regular, size: 16))
                            .foregroundColor(viewModel.buttonTextColor)
                        
                        Spacer()
                    }else if sortedTasks.isEmpty {
                        VStack{
                            Spacer()
                            
                            Image("boxImage")
                                .resizable()
                                .frame(width: 134, height: 134)
                            
                            Text("No results found.")
                                .font(.poppins(.medium, size: 20))
                                .foregroundColor(viewModel.buttonTextColor)
                            
                            Text("Try adjusting filters.")
                                .font(.poppins(.regular, size: 12))
                                .foregroundColor(viewModel.buttonTextColor)
                            
                            Spacer()
                        }
                    }else{
                        ScrollView{
                            DropdownFilter(title: "Status", options: categoryFilters, selection: $selectedCategory)
                                .padding(.horizontal)
                                .padding(.bottom)
                            
                            LazyVStack(spacing: 12) {
                                ForEach(sortedTasks) { task in
                                    TaskContainer(task: task, secondatyButtonAction: {
                                        selectedTask = task
                                    }, primaryButtonAction: {
                                        selectedTask = task
                                    })
                                }
                            }
                            .padding(.horizontal)
                            .animation(.easeInOut(duration: 0.3), value: selectedCategory)
                            
                        }
                    }
                }
                
                Spacer()
            }
        }
        .fullScreenCover(item: $selectedTask) { task in
            TaskDetails(task: task)
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    SearchList()
        .environmentObject(ViewModel())
}
