//
//  FavoritesContainer.swift
//  DousSpint
//
//  Created by Никита on 03.10.2025.
//

import SwiftUI

struct FavoritesContainer: View {
    let task: TaskItem
    
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
    
    var body: some View {
        VStack(){
            HStack{
                Spacer()
                
                Image("star")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.horizontal)
            }
            .padding(.top)
            
            Text(task.title)
                .font(.calistoga(size: 20))
                .foregroundColor(textColor)
            
            HStack{
                Group{
                    HStack{
                        Image("categoryIcon")
                        
                        Text(task.category)
                    }
                    
                    Text("·")
                    
                    HStack{
                        Image("difficultyIcon")
                        
                        Text(task.difficulty)
                    }
                    
                    Text("·")
                    
                    HStack{
                        Image("timeIcon")
                        
                        Text("up to \(task.estimatedTime) min")
                        
                    }
                    
                }
                .font(.poppins(.medium, size: 16))
                .foregroundStyle(Color(r: 203, g: 37, b: 247))
            }
            .padding(.bottom, 40)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 165)
        .background(settings.themeBackgroundButton(for: systemScheme))
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.init(r: 246, g: 64, b: 241, alpha: 0.45), lineWidth: 1)
        }
    }
    
}

#Preview {
    FavoritesContainer(task: TaskItem(
        id: 1,
        title: "Drink a full glass of water with gratitude.",
        description: "Walk slowly, paying attention to each step and your surroundings. Notice the sounds, smells, and sensations around you.",
        category: "Body",
        difficulty: "Easy",
        estimatedTime: 5,
        tags: ["mindfulness", "movement", "outdoor"]
    ))
    .environmentObject(ViewModel())
}

