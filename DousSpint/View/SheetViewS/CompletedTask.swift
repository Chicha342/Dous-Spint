//
//  CompletedTask.swift
//  DousSpint
//
//  Created by Никита on 03.10.2025.
//

import SwiftUI

struct CompletedTask: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Environment(\.colorScheme) var systemScheme
    @Environment(\.dismiss) var dismiss
    
    let task: TaskItem
    let status: SpinResult.Status
    let timeSpent: TimeInterval?
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .fill(viewModel.backgroundColor)
                    .ignoresSafeArea()
                
                if status == .completed {
                    VStack{
                        Image("party2Image")
                            .resizable()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                        Spacer()
                    }
                }
                
                VStack(alignment: .center){
                    HStack(spacing: 14){
                        Button(action: {
                            NotificationCenter.default.post(name: .closeAllSheets, object: nil)
                        }, label: {
                            Image("arrowBack")
                        })
                        
                        
                        Text(task.title)
                            .font(.calistoga(size: 24))
                            .foregroundColor(viewModel.headerTextColor)
                            .lineLimit(1)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    
                    Spacer()
                    
                    CompletedContainer(
                        task: SpinResult(
                            id: UUID(),
                            taskId: task.id,
                            date: Date(),
                            status: status,
                            completedAt: Date(),
                            notes: nil
                        ), timeSpent: timeSpent, taskDetails: task
                    )
                    .padding(.horizontal, 50)
                    
                    Spacer()
                    
                    if status == .completed {
                        Image("partyImage")
                            .resizable()
                            .frame(width: 90, height: 96)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 18){
                        MainCustomButton(title: "Save to History", action: {
                            NotificationCenter.default.post(name: .closeAllSheets, object: nil)
                        }, height: 56)
                        
                        SecondMainButton(title: "Next Random", action: {
                            
                        }, height: 56)
                        
                        SecondMainButton(title: "Back To Home", action: {
                            NotificationCenter.default.post(name: .closeAllSheets, object: nil)
                        }, height: 56)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 5)
                }
            }
        }
    }
}

#Preview {
    CompletedTask(task: TaskItem(
        id: 5,
        title: "Drink a full glass of water with gratitude",
        description: "Drink water mindfully, appreciating its refreshing qualities and how it nourishes your body.",
        category: "Body",
        difficulty: "Easy",
        estimatedTime: 1,
        tags: ["hydration", "gratitude", "health"]
    ), status: SpinResult.Status.completed, timeSpent: TimeInterval?(60))
    .environmentObject(ViewModel())
}
