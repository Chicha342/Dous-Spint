//
//  TaskContainer.swift
//  DousSpint
//
//  Created by Никита on 01.10.2025.
//

import SwiftUI

struct TaskContainer: View {
    let task: TaskItem
    let onTap: () -> Void
    
    @Environment(\.colorScheme) var systemScheme
    
    @EnvironmentObject var settings: ViewModel
    
    var textColor: Color {
        switch settings.selectedTheme {
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 234/255, green: 180/255, blue: 248/255, alpha: 1) :
                UIColor(red: 33/255, green: 0/255, blue: 42/255, alpha: 1)
            })
        case .light:
            return .init(r: 33, g: 0, b: 42)
        case .dark:
            return .init(r: 234, g: 180, b: 248)
        }
    }
    
    var secondTextColor: Color {
        switch settings.selectedTheme {
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 188/255, green: 74/255, blue: 217/255, alpha: 1) :
                UIColor(red: 203/255, green: 37/255, blue: 247/255, alpha: 1)
            })
        case .light:
            return .init(r: 203, g: 37, b: 247)
        case .dark:
            return .init(r: 188, g: 74, b: 217)
        }
    }
    
    var body: some View {
        VStack{
            Text(task.title)
                .font(.poppins(.medium, size: 16))
                .foregroundColor(textColor)
                .multilineTextAlignment(.center)
            
            HStack{
                Group{
                    Text(task.category)
                    
                    Text("·")
                    
                    Text(task.difficulty)
                    
                    Text("·")
                    
                    Text("up to \(task.estimatedTime) min")
                }
                .font(.poppins(.medium, size: 12))
                .foregroundStyle(secondTextColor)
            }
            
            HStack{
                
                DetailsCustomButton(title: "Details", action: { }, with: 130, height: 44)
                
                MainCustomButton(title: "Start", action: { }, width: 130, height: 44)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(themeBackgroundButton(for: systemScheme))
        .cornerRadius(24)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.init(r: 246, g: 64, b: 241, alpha: 0.45), lineWidth: 1)
        }
    }
    
    func themeBackgroundButton(for systemScheme: ColorScheme) -> LinearGradient {
        switch settings.selectedTheme {
        case .light:
            return LinearGradient(
                colors: [Color(r: 233, g: 219, b: 255),
                         Color(r: 246, g: 233, b: 255)],
                startPoint: .top, endPoint: .bottom
            )
        case .dark:
            return LinearGradient(
                colors: [Color(r: 51, g: 13, b: 109),
                         Color(r: 70, g: 8, b: 83)],
                startPoint: .top, endPoint: .bottom
            )
        case .system:
            return systemScheme == .dark
            ? LinearGradient(
                colors: [Color(r: 51, g: 13, b: 109),
                         Color(r: 70, g: 8, b: 83)],
                startPoint: .top, endPoint: .bottom
            )
            : LinearGradient(
                colors: [Color(r: 233, g: 219, b: 255),
                         Color(r: 246, g: 233, b: 255)],
                startPoint: .top, endPoint: .bottom
            )
        }
    }
}

#Preview {
    TaskContainer(task: TaskItem(
        id: UUID(),
        title: "Take a mindful walk for 5 minutes",
        description: "Walk slowly, paying attention to each step and your surroundings. Notice the sounds, smells, and sensations around you.",
        category: "Body",
        difficulty: "Easy",
        estimatedTime: 5,
        tags: ["mindfulness", "movement", "outdoor"]
    ), onTap: {})
    .environmentObject(ViewModel())
}


#Preview {
    TaskContainer(task: TaskItem(
        id: UUID(),
        title: "Take a mindful walk for 5 minutes",
        description: "Walk slowly, paying attention to each step and your surroundings. Notice the sounds, smells, and sensations around you.",
        category: "Body",
        difficulty: "Easy",
        estimatedTime: 5,
        tags: ["mindfulness", "movement", "outdoor"]
    ), onTap: {})
    .environmentObject(ViewModel())
    .colorScheme(.dark)
}
