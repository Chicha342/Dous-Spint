//
//  TaskDetails.swift
//  DousSpint
//
//  Created by Никита on 02.10.2025.
//

import SwiftUI

struct TaskDetails: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Environment(\.colorScheme) var systemScheme
    @Environment(\.dismiss) var dismiss
    
    @State private var isRunTask = false
    
    let task: TaskItem
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(viewModel.backgroundColor)
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                HStack(spacing: 14){
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image("arrowBack")
                    })
                    
                    
                    Text(task.title)
                        .font(.calistoga(size: 24))
                        .foregroundColor(viewModel.headerTextColor)
                        .lineLimit(1)
                    
                    Spacer()
                    Button(action: {
                        viewModel.toggleFavorite(taskId: task.id) 
                    }, label: {
                        Image("star")
                            .resizable()
                            .frame(width: 24, height: 24)
                    })
                    
                }
                .padding(.top)
                .padding(.horizontal)
                
                ScrollView{
                    VStack(alignment: .leading){
                        
                        //Task
                        Text("TASK")
                            .font(.poppins(.medium, size: 12))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(viewModel.themeBackgroundContainers(for: systemScheme))
                            .cornerRadius(5)
                            .foregroundColor(viewModel.buttonTextColor)
                            .padding(.top)
                        
                        Text(task.title)
                            .font(.calistoga(size: 34))
                            .foregroundColor(viewModel.buttonTextColor)
                        
                        //Descriptions
                        Text("DESCRIPTION")
                            .font(.poppins(.medium, size: 12))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(viewModel.themeBackgroundContainers(for: systemScheme))
                            .cornerRadius(5)
                            .foregroundColor(viewModel.buttonTextColor)
                            .padding(.top)
                        
                        if !task.description.isEmpty {
                            Text(task.description)
                                .font(.poppins(.regular, size: 16))
                                .foregroundColor(viewModel.buttonTextColor)
                        }else{
                            HStack{
                                Image("errorImage")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                
                                Text("Details unavailable")
                                    .font(.poppins(.regular, size: 16))
                                    .foregroundColor(viewModel.buttonTextColor)
                            }
                        }
                        
                        //Metadata
                        Text("METADATA")
                            .font(.poppins(.medium, size: 12))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(viewModel.themeBackgroundContainers(for: systemScheme))
                            .cornerRadius(5)
                            .foregroundColor(viewModel.buttonTextColor)
                            .padding(.top)
                        
                        VStack(alignment: .leading){
                            HStack{
                                Image("categoryIcon")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                
                                Text("Category: ")
                                    .font(.poppins(.regular, size: 16))
                                    .foregroundColor(viewModel.buttonTextColor)
                                
                                Text(task.category)
                                    .font(.poppins(.regular, size: 16))
                                    .foregroundColor(Color.init(r: 203, g: 37, b: 247))
                            }
                            HStack{
                                Image("difficultyIcon")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                
                                Text("Difficulty: ")
                                    .font(.poppins(.regular, size: 16))
                                    .foregroundColor(viewModel.buttonTextColor)
                                
                                Text(task.difficulty)
                                    .font(.poppins(.regular, size: 16))
                                    .foregroundColor(Color.init(r: 203, g: 37, b: 247))
                            }
                            HStack{
                                Image("timeIcon")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                
                                Text("Time:: ")
                                    .font(.poppins(.regular, size: 16))
                                    .foregroundColor(viewModel.buttonTextColor)
                                
                                Text("up to \(task.estimatedTime) min")
                                    .font(.poppins(.regular, size: 16))
                                    .foregroundColor(Color.init(r: 203, g: 37, b: 247))
                            }
                        }
                        
                        //Extratips
                        Text("EXTRA TIPS")
                            .font(.poppins(.medium, size: 12))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(viewModel.themeBackgroundContainers(for: systemScheme))
                            .cornerRadius(5)
                            .foregroundColor(viewModel.buttonTextColor)
                            .padding(.top)
                        
                        Text("This task can be done at your desk.")
                            .font(.poppins(.regular, size: 16))
                            .foregroundColor(viewModel.buttonTextColor)
                        
                        
                        //Button
                        MainCustomButton(title: "Start", action: {
                            isRunTask = true
                        }, height: 56)
                        .padding(.top, 40)
                    }
                    .padding(.horizontal, 16)
                    
                    
                    
                    Spacer()
                }
            }
            
        }
        .fullScreenCover(isPresented: $isRunTask) {
            TaskRun(task: task)
        }
    }
}

#Preview {
    TaskDetails(task: TaskItem(
        id: 4,
        title: "Hold a plank and repeat an affirmation: 'I am strong'",
        description: "Maintain plank position while repeating the affirmation with each breath.",
        category: "Body",
        difficulty: "Medium",
        estimatedTime: 1,
        tags: ["core", "affirmation", "mind-body"]
    ))
        .environmentObject(ViewModel())
}
