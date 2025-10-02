//
//  Models.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import Foundation
import SwiftUICore

struct TaskItem: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let difficulty: String
    let estimatedTime: Int
    let tags: [String]
}

struct SpinResult: Identifiable, Codable {
    let id: UUID
    let taskId: Int
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

extension TaskItem {
    static let sampleTasks: [TaskItem] = [
            // Body (6)
            TaskItem(
                id: 1,
                title: "Take a mindful walk for 5 minutes",
                description: "Walk slowly, paying attention to each step and your surroundings. Notice the sounds, smells, and sensations around you.",
                category: "Body",
                difficulty: "Easy",
                estimatedTime: 5,
                tags: ["mindfulness", "movement", "outdoor"]
            ),
            TaskItem(
                id: 2,
                title: "Stretch your whole body with slow breaths",
                description: "Stretch each major muscle group while breathing deeply. Hold each stretch for 15-20 seconds.",
                category: "Body",
                difficulty: "Easy",
                estimatedTime: 3,
                tags: ["stretching", "breathing", "flexibility"]
            ),
            TaskItem(
                id: 3,
                title: "Do 10 push-ups while focusing on strength",
                description: "Perform push-ups with proper form, focusing on your muscle engagement and breathing.",
                category: "Body",
                difficulty: "Medium",
                estimatedTime: 2,
                tags: ["strength", "exercise", "focus"]
            ),
            TaskItem(
                id: 4,
                title: "Hold a plank and repeat an affirmation: 'I am strong'",
                description: "Maintain plank position while repeating the affirmation with each breath.",
                category: "Body",
                difficulty: "Medium",
                estimatedTime: 1,
                tags: ["core", "affirmation", "mind-body"]
            ),
            TaskItem(
                id: 5,
                title: "Drink a full glass of water with gratitude",
                description: "Drink water mindfully, appreciating its refreshing qualities and how it nourishes your body.",
                category: "Body",
                difficulty: "Easy",
                estimatedTime: 1,
                tags: ["hydration", "gratitude", "health"]
            ),
            TaskItem(
                id: 6,
                title: "Dance freely to one song, let your body lead",
                description: "Put on your favorite song and move without judgment or specific steps.",
                category: "Body",
                difficulty: "Easy",
                estimatedTime: 4,
                tags: ["dance", "expression", "joy"]
            ),
            
            // Mind (6)
            TaskItem(
                id: 7,
                title: "Write down 3 things you want to achieve this week",
                description: "Be specific and realistic with your goals. Write why each goal matters to you.",
                category: "Mind",
                difficulty: "Medium",
                estimatedTime: 5,
                tags: ["planning", "goals", "productivity"]
            ),
            TaskItem(
                id: 8,
                title: "Declutter one small corner of your room",
                description: "Choose one small area to organize and tidy up. Enjoy the sense of accomplishment.",
                category: "Mind",
                difficulty: "Easy",
                estimatedTime: 10,
                tags: ["organization", "clarity", "space"]
            ),
            TaskItem(
                id: 9,
                title: "Spend 2 minutes focusing only on your breathing",
                description: "Sit comfortably and bring your full attention to the sensation of your breath.",
                category: "Mind",
                difficulty: "Easy",
                estimatedTime: 2,
                tags: ["meditation", "focus", "calm"]
            ),
            TaskItem(
                id: 10,
                title: "Journal one thought that keeps repeating in your head",
                description: "Write it down to gain clarity and release it from circulating in your mind.",
                category: "Mind",
                difficulty: "Easy",
                estimatedTime: 3,
                tags: ["journaling", "clarity", "release"]
            ),
            TaskItem(
                id: 11,
                title: "Read one inspiring quote aloud",
                description: "Find a quote that resonates with you and speak it with conviction.",
                category: "Mind",
                difficulty: "Easy",
                estimatedTime: 2,
                tags: ["inspiration", "motivation", "voice"]
            ),
            TaskItem(
                id: 12,
                title: "Switch your phone to silent for 10 minutes and just be",
                description: "Disconnect from digital distractions and simply exist in the present moment.",
                category: "Mind",
                difficulty: "Medium",
                estimatedTime: 10,
                tags: ["digital detox", "presence", "mindfulness"]
            ),
            
            // Soul (6)
            TaskItem(
                id: 13,
                title: "Think of one moment you are deeply grateful for",
                description: "Recall a specific moment and sit with the feeling of gratitude.",
                category: "Soul",
                difficulty: "Easy",
                estimatedTime: 2,
                tags: ["gratitude", "reflection", "appreciation"]
            ),
            TaskItem(
                id: 14,
                title: "Write down one value that guides your life",
                description: "Identify a core value and reflect on how it influences your decisions.",
                category: "Soul",
                difficulty: "Medium",
                estimatedTime: 4,
                tags: ["values", "purpose", "self-awareness"]
            ),
            TaskItem(
                id: 15,
                title: "Spend 2 minutes in silence, eyes closed",
                description: "Simply be with yourself without any external stimulation.",
                category: "Soul",
                difficulty: "Easy",
                estimatedTime: 2,
                tags: ["silence", "stillness", "inner peace"]
            ),
            TaskItem(
                id: 16,
                title: "Draw a simple symbol of how you feel today",
                description: "Let your hand move freely without judgment - no artistic skill needed.",
                category: "Soul",
                difficulty: "Easy",
                estimatedTime: 3,
                tags: ["expression", "emotions", "creativity"]
            ),
            TaskItem(
                id: 17,
                title: "Listen to calming sounds of nature",
                description: "Find a quiet space and listen to nature sounds or sit near a window.",
                category: "Soul",
                difficulty: "Easy",
                estimatedTime: 5,
                tags: ["nature", "calm", "sounds"]
            ),
            TaskItem(
                id: 18,
                title: "Light a candle and just watch the flame for 1 minute",
                description: "Focus on the flickering flame and let your thoughts drift away.",
                category: "Soul",
                difficulty: "Easy",
                estimatedTime: 1,
                tags: ["meditation", "focus", "peace"]
            ),
            
            // Connect (6)
            TaskItem(
                id: 19,
                title: "Send a kind message to someone you miss",
                description: "Reach out with a genuine message - no need for a long conversation.",
                category: "Connect",
                difficulty: "Easy",
                estimatedTime: 3,
                tags: ["connection", "kindness", "relationships"]
            ),
            TaskItem(
                id: 20,
                title: "Call a loved one and tell them one positive memory",
                description: "Share a happy memory and listen to their response.",
                category: "Connect",
                difficulty: "Medium",
                estimatedTime: 5,
                tags: ["communication", "memories", "love"]
            ),
            TaskItem(
                id: 21,
                title: "Give a compliment to a stranger or colleague",
                description: "Offer a genuine, specific compliment to brighten someone's day.",
                category: "Connect",
                difficulty: "Easy",
                estimatedTime: 1,
                tags: ["kindness", "social", "appreciation"]
            ),
            TaskItem(
                id: 22,
                title: "Write down the name of a person you are grateful for",
                description: "Reflect on why this person is important in your life.",
                category: "Connect",
                difficulty: "Easy",
                estimatedTime: 2,
                tags: ["gratitude", "relationships", "reflection"]
            ),
            TaskItem(
                id: 23,
                title: "Do one small act of kindness today",
                description: "Look for an opportunity to help someone in a small but meaningful way.",
                category: "Connect",
                difficulty: "Easy",
                estimatedTime: 2,
                tags: ["kindness", "service", "compassion"]
            ),
            TaskItem(
                id: 24,
                title: "Thank someone near you for something they did",
                description: "Acknowledge and appreciate someone's action, no matter how small.",
                category: "Connect",
                difficulty: "Easy",
                estimatedTime: 1,
                tags: ["appreciation", "gratitude", "acknowledgment"]
            ),
            
            // Create (6)
            TaskItem(
                id: 25,
                title: "Doodle freely for 2 minutes — no rules",
                description: "Let your pen move without planning - enjoy the process of creation.",
                category: "Create",
                difficulty: "Easy",
                estimatedTime: 2,
                tags: ["doodling", "expression", "fun"]
            ),
            TaskItem(
                id: 26,
                title: "Write one line of poetry about your mood",
                description: "Capture your current feeling in a single poetic line.",
                category: "Create",
                difficulty: "Medium",
                estimatedTime: 3,
                tags: ["poetry", "expression", "emotions"]
            ),
            TaskItem(
                id: 27,
                title: "Take a photo of something that inspires you",
                description: "Look for beauty or meaning in your immediate environment.",
                category: "Create",
                difficulty: "Easy",
                estimatedTime: 2,
                tags: ["photography", "observation", "inspiration"]
            ),
            TaskItem(
                id: 28,
                title: "Invent a silly new word and say it out loud",
                description: "Have fun with language and sound - creativity without pressure.",
                category: "Create",
                difficulty: "Easy",
                estimatedTime: 1,
                tags: ["language", "fun", "imagination"]
            ),
            TaskItem(
                id: 29,
                title: "Hum a melody you've never sung before",
                description: "Let a new tune emerge naturally without thinking too much.",
                category: "Create",
                difficulty: "Easy",
                estimatedTime: 1,
                tags: ["music", "improvisation", "sound"]
            ),
            TaskItem(
                id: 30,
                title: "Build a 3-item story (3 random words → tiny story)",
                description: "Pick three random objects around you and create a micro-story connecting them.",
                category: "Create",
                difficulty: "Medium",
                estimatedTime: 4,
                tags: ["storytelling", "imagination", "creativity"]
            )
        ]
}
