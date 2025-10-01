//
//  Models.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import Foundation
import SwiftUICore

struct TaskItem: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let category: String
    let difficulty: String
    let estimatedTime: Int
    let tags: [String]
}


struct SpinResult: Identifiable, Codable {
    let id: UUID
    let taskId: UUID
    let date: Date
    var status: Status
    var completedAt: Date?
    var notes: String?
    
    enum Status: String, Codable {
        case new, inProgress, completed, skipped
    }
}

struct UserSettings: Codable {
    var theme: Theme
    var spinLimitPerDay: Int
    var autoStartNext: Bool
    var haptics: Bool
    
    enum Theme: String, Codable {
        case system, light, dark
    }
    
    static let `default` = UserSettings(theme: .system,
                                        spinLimitPerDay: 3,
                                        autoStartNext: true,
                                        haptics: true)
}

struct Progress: Codable {
    var tasksCompleted: Int
    var streakDays: Int
    var categoriesStats: [String: Int]
}


enum TabItem: CaseIterable {
    case home
    case search
    case history
    case statistics
    case favorites
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .history: return "History"
        case .statistics: return "Statistics"
        case .favorites: return "Favorites"
        }
    }
    
    var iconDefault: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .history: return "History"
        case .statistics: return "Statistics"
        case .favorites: return "Favorites"
        }
    }
    
    var iconSelected: String {
        switch self {
        case .home: return "HomeSelected"
        case .search: return "SearchSelected"
        case .history: return "HistorySelected"
        case .statistics: return "StatisticsSelected"
        case .favorites: return "FavoritesSelected"
        }
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .home:
            HomeView()
        case .search:
            SearchView()
        case .history:
            HistoryView()
        case .statistics:
            StatisticsView()
        case .favorites:
            FavoritesView()
        }
    }
}

struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
    let color: Color
    //let bgImage: String
}

struct CategoryButton {
    let title: String
    let action: () -> Void
}
