//
//  CompletedContainer.swift
//  DousSpint
//
//  Created by Никита on 03.10.2025.
//

import SwiftUI

struct CompletedContainer: View {
    @Environment(\.colorScheme) var systemScheme
    
    @EnvironmentObject var settings: ViewModel
    let task: SpinResult
    let timeSpent: TimeInterval?
    let taskDetails: TaskItem
    
    var body: some View {
        VStack{
            VStack{
                Text(task.status.rawValue.capitalized)
                    .foregroundColor(settings.headerTextColor)
                    .font(.calistoga(size: 24))
                    .padding(.top)
                
                Spacer()
                
                VStack(spacing: 5){
                    HStack{
                        Text("Category: \(taskDetails.category)")
                            .foregroundColor(customColor())
                        
                        Text("\(taskDetails.category)")
                            .foregroundColor(Color.init(r: 203, g: 37, b: 247))
                        
                    }
                    HStack{
                        Text("Difficulty: ")
                            .foregroundColor(customColor())
                        
                        Text("\(taskDetails.difficulty)")
                            .foregroundColor(Color.init(r: 203, g: 37, b: 247))
                    }
                    HStack{
                        Text("Time: ")
                            .foregroundColor(customColor())
                        
                        Text(formatTimeSpent(timeSpent))
                            .foregroundColor(Color.init(r: 203, g: 37, b: 247))
                    }
                }
                .font(.calistoga(size: 16))
                .padding(.bottom)
                
                Spacer()
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background{
                customImage(for: systemScheme)
                    .resizable()
                    .frame(width: 276, height: 200)
            }
            .padding(.horizontal)
            
            
        }
    }
    
    private func customImage(for colorScheme: ColorScheme) -> Image {
        switch settings.selectedTheme {
        case .system:
            return colorScheme == .dark ?
            Image("completedCardDark") :
            Image("completedCardLight")
        case .light:
            return Image("completedCardLight")
        case .dark:
            return Image("completedCardDark")
        }
    }

    
    private func formatTimeSpent(_ timeInterval: TimeInterval?) -> String {
        guard let time = timeInterval else { return "N/A" }
        
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func customColor() -> Color {
        switch settings.selectedTheme {
        case .light:
            return Color(r: 33, g: 0, b: 42)
        case .dark:
            return Color(r: 234, g: 180, b: 248)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark
                ? UIColor(red: 234/255, green: 180/255, blue: 248/255, alpha: 1)
                : UIColor(red: 33/255, green: 0/255, blue: 42/255, alpha: 1)
            })
        }
    }
    
    private func customBgColor() -> LinearGradient {
        switch settings.selectedTheme {
        case .system:
            return systemScheme == .dark
            ? LinearGradient(colors: [
                Color(r: 77, g: 1, b: 87),
                Color(r: 102, g: 12, b: 62)
            ], startPoint: .top, endPoint: .bottom)
            : LinearGradient(colors: [
                Color(r: 254, g: 245, b: 255),
                Color(r: 255, g: 234, b: 246)
            ], startPoint: .top, endPoint: .bottom)
        case .light:
            return LinearGradient(colors: [
                Color(r: 254, g: 245, b: 255),
                Color(r: 255, g: 234, b: 246)
            ], startPoint: .top, endPoint: .bottom)
        case .dark:
            return LinearGradient(colors: [
                Color(r: 77, g: 1, b: 87),
                Color(r: 102, g: 12, b: 62)
            ], startPoint: .top, endPoint: .bottom)
        }
    }
}

#Preview {
    CompletedContainer(task: SpinResult(
        id: UUID(),
        taskId: 5,
        date: Date(),
        status: .completed,
        completedAt: Date(),
        notes: nil
    ), timeSpent: TimeInterval?(100), taskDetails: TaskItem(
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
