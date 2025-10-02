//
//  TaskRun.swift
//  DousSpint
//
//  Created by Никита on 02.10.2025.
//

import SwiftUI

struct TaskRun: View {
    @EnvironmentObject private var viewModel: ViewModel
    @Environment(\.colorScheme) var systemScheme
    @Environment(\.dismiss) var dismiss
    
    @State var timeRemaining: Int
    @State var timer: Timer? = nil
    
    init(task: TaskItem) {
        self.task = task
        _timeRemaining = State(initialValue: task.estimatedTime * 60)
    }
    
    let task: TaskItem
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .fill(viewModel.backgroundColor)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading){
                    HStack(spacing: 14){
                        Button(action: {
                            stopTimer()
                            dismiss()
                        }, label: {
                            Image("arrowBack")
                        })
                        
                        
                        Text(task.title)
                            .font(.calistoga(size: 24))
                            .foregroundColor(viewModel.headerTextColor)
                            .lineLimit(1)
                        
                    }
                    .padding(.horizontal)
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
                            
                            TimeContainer(timeStr: formatTime(timeRemaining))
                                .onAppear {
                                    startCountdown()
                                }
                            
                            Spacer()
                            
                            VStack(spacing: 20){
                                SkipCuptomButton(title: "Skip", action: {
                                    
                                })
                                
                                MainCustomButton(title: "Done", action: {
                                    
                                }, height: 56)
                            }
                            .padding(.bottom)
                            
                        }
                        
                        
                        .padding(.horizontal)
                    
                }
            }
        }
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                //Добавить действие при за
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    TaskRun(task: TaskItem(
        id: 5,
        title: "Drink a full glass of water with gratitude",
        description: "Drink water mindfully, appreciating its refreshing qualities and how it nourishes your body.",
        category: "Body",
        difficulty: "Easy",
        estimatedTime: 1,
        tags: ["hydration", "gratitude", "health"]
    ))
    .environmentObject(ViewModel())
}
