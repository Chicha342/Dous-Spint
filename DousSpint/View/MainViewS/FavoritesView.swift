//
//  FavoritesView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var settings: ViewModel
    @Environment(\.colorScheme) var systemScheme
     
    var body: some View {
        ZStack{
            settings.backgroundColor
                .ignoresSafeArea()
            
            VStack{
                Text("Favorites")
                    .font(.calistoga(size: 24))
                    .foregroundColor(settings.headerTextColor)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top)
                
                
                
                if settings.favorites.isEmpty {
                    Spacer()
                    
                    Image("starImage")
                        .resizable()
                        .frame(width: 74, height: 74)
                    
                    Text("No favorites yet.")
                        .font(.poppins(.medium, size: 20))
                        .foregroundStyle(customColorForText())
                    
                    Text("Add tasks to favorites from details screen.")
                        .font(.poppins(.regular, size: 12))
                        .foregroundStyle(customColorForText())
                } else {
                    ScrollView{
                        ForEach(favoriteTasks, id: \.id) { task in
                            SwipeToDeleteRow(content: {
                                FavoritesContainer(task: task)
                            }, onDelete: {
                                withAnimation {
                                    settings.toggleFavorite(taskId: task.id)
                                }
                            })
                            .padding(.bottom, 12)
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
    
    private var favoriteTasks: [TaskItem] {
        settings.favorites.compactMap { taskId in
            settings.allTasks.first { $0.id == taskId }
        }
    }
    
    private func customColorForText() -> Color {
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
    FavoritesView()
        .environmentObject(ViewModel())
        .colorScheme(.light)
}

#Preview {
    FavoritesView()
        .environmentObject(ViewModel())
        .colorScheme(.dark)
}
