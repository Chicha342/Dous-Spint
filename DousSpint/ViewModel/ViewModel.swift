//
//  ViewModel.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var allTasks: [TaskItem] = TaskItem.sampleTasks
    @Published var spinResults: [SpinResult] = [] {
        didSet {
            saveSpinResults()
        }
    }
    
    @Published var favorites: [Int] = [] {
        didSet {
            saveFavorites()
        }
    }
    
    init() {
        if let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme"),
           let theme = AppTheme(rawValue: savedTheme) {
            selectedTheme = theme
        }
        
        loadSpinResults()
        loadFavorites()
    }
    
    @Published var selectedTheme: AppTheme = .system {
        didSet {
            UserDefaults.standard.set(selectedTheme.rawValue, forKey: "selectedTheme")
        }
    }
    
    func changeTheme(_ theme: AppTheme) {
        selectedTheme = theme
    }
    
    @Published var navigationPath = NavigationPath()
    @Published var showSettings = false
    
    func showError() {
        DispatchQueue.main.async {
            withAnimation {
                self.mainError = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.mainError = false
                }
            }
        }
    }
    
    @Published var isLoading: Bool = false
    @Published var mainError: Bool = false
    
}

enum AppTheme: String, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
}

//MARK: - Data
extension ViewModel {
    
    var myTasks: [TaskItem] {
        let activeTasks = spinResults
            .filter { $0.status == .new || $0.status == .inProgress }
            .sorted { $0.date > $1.date }
        
        return activeTasks.compactMap { result in
            allTasks.first { $0.id == result.taskId }
        }
    }
    
    var completedTasks: [TaskItem] {
        let completedResults = spinResults
            .filter { $0.status == .completed }
            .sorted { ($0.completedAt ?? $0.date) > ($1.completedAt ?? $1.date) }
        
        return completedResults.compactMap { result in
            allTasks.first { $0.id == result.taskId }
        }
    }
    
    var currentTask: TaskItem? {
        guard let latestSpin = spinResults
            .filter({ $0.status == .new || $0.status == .inProgress })
            .sorted(by: { $0.date > $1.date })
            .first else { return nil }
        
        return allTasks.first { $0.id == latestSpin.taskId }
    }
    
    var spinsLeftToday: Int {
        let todaySpins = spinResults.filter {
            Calendar.current.isDateInToday($0.date)
        }.count
        return max(0, 3 - todaySpins)
    }
    
    func spinWheel() -> TaskItem? {
        guard spinsLeftToday > 0 else { return nil }
        
        let availableTasks = allTasks.filter { task in
            !spinResults.contains { $0.taskId == task.id && $0.status == .completed }
        }
        
        guard let randomTask = availableTasks.randomElement() else { return nil }
        
        let spinResult = SpinResult(
            id: UUID(),
            taskId: randomTask.id,
            date: Date(),
            status: .new
        )
        spinResults.append(spinResult)
        
        return randomTask
    }
    
    func markTaskCompleted(taskId: Int, status: SpinResult.Status = .completed) {
        if let index = spinResults.firstIndex(where: { $0.taskId == taskId }) {
            spinResults[index].status = status
            if status == .completed {
                spinResults[index].completedAt = Date()
            }
        }
    }
    
    private func saveSpinResults() {
        if let encoded = try? JSONEncoder().encode(spinResults) {
            UserDefaults.standard.set(encoded, forKey: "spinResults")
        }
    }
    
    private func loadSpinResults() {
        if let data = UserDefaults.standard.data(forKey: "spinResults"),
           let decoded = try? JSONDecoder().decode([SpinResult].self, from: data) {
            spinResults = decoded
        }
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(favorites, forKey: "favorites")
    }
    
    private func loadFavorites() {
        if let favoritesArray = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
            favorites = favoritesArray
        }
    }
    
    func toggleFavorite(taskId: Int) {
        if favorites.contains(taskId) {
            favorites.removeAll { $0 == taskId }
        } else {
            favorites.append(taskId)
        }
    }
    
    func isFavorite(taskId: Int) -> Bool {
        return favorites.contains(taskId)
    }
    
    var historyResults: [SpinResult] {
        return spinResults
            .filter { $0.status == .completed || $0.status == .skipped }
            .sorted { ($0.completedAt ?? $0.date) > ($1.completedAt ?? $1.date) }
    }
}


//MARK: - UI customColors
extension ViewModel {
    var colorScheme: ColorScheme? {
        switch selectedTheme {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
    
    var headerTextColor: Color {
        switch self.selectedTheme {
        case .light:
            return .init(r: 255, g: 123, b: 0)
        case .dark:
            return .init(r: 255, g: 235, b: 192)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 255, g: 235, b: 192)) :
                UIColor(Color(r: 255, g: 123, b: 0))
            })
        }
    }
    
    var skipButtonColor: Color {
        switch self.selectedTheme {
        case .light:
            return .init(r: 212, g: 84, b: 255)
        case .dark:
            return .init(r: 203, g: 37, b: 247)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 203, g: 37, b: 247)) :
                UIColor(Color(r: 212, g: 84, b: 255))
            })
        }
    }
    
    var backgroundColor: Color {
        switch self.selectedTheme {
        case .light:
            return .white
        case .dark:
            return Color(r: 49, g: 7, b: 59)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 49, g: 7, b: 59)) :
                    .white
            })
        }
    }
    
    func themeBackgroundButton(for systemScheme: ColorScheme) -> LinearGradient {
        switch selectedTheme {
        case .light:
            return LinearGradient(
                colors: [Color(r: 235, g: 176, b: 255),
                         Color(r: 188, g: 149, b: 255)],
                startPoint: .top, endPoint: .bottom
            )
        case .dark:
            return LinearGradient(
                colors: [Color(r: 92, g: 24, b: 115),
                         Color(r: 48, g: 12, b: 109)],
                startPoint: .top, endPoint: .bottom
            )
        case .system:
            return systemScheme == .dark
            ? LinearGradient(
                colors: [Color(r: 92, g: 24, b: 115),
                         Color(r: 48, g: 12, b: 109)],
                startPoint: .top, endPoint: .bottom
            )
            : LinearGradient(
                colors: [Color(r: 235, g: 176, b: 255),
                         Color(r: 188, g: 149, b: 255)],
                startPoint: .top, endPoint: .bottom
            )
        }
    }
    
    var buttonTextColor: Color {
        switch self.selectedTheme {
        case .light:
            return .init(r: 33, g: 0, b: 42)
        case .dark:
            return .init(r: 234, g: 180, b: 248)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 234, g: 180, b: 248)) :
                UIColor(Color(r: 33, g: 0, b: 42))
            })
        }
    }
    
    var selectedButtonTextColor: Color {
        switch self.selectedTheme {
        case .light:
            return .init(r: 255, g: 255, b: 255)
        case .dark:
            return .init(r: 255, g: 245, b: 192)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 255, g: 245, b: 192)) :
                UIColor(Color(r: 255, g: 255, b: 255))
            })
        }
    }
    
    func selectedBg(for systemScheme: ColorScheme) -> LinearGradient {
        switch self.selectedTheme {
        case .system:
            systemScheme == .dark
            ? LinearGradient(
                colors: [Color(r: 77, g: 1, b: 87),
                         Color(r: 102, g: 12, b: 62)],
                startPoint: .top, endPoint: .bottom
            )
            : LinearGradient(
                colors: [Color(r: 238, g: 111, b: 255),
                         Color(r: 255, g: 42, b: 160)],
                startPoint: .top, endPoint: .bottom
            )
        case .light:
            LinearGradient(
                colors: [Color(r: 238, g: 111, b: 255),
                         Color(r: 255, g: 42, b: 160)],
                startPoint: .top, endPoint: .bottom
            )
        case .dark:
            LinearGradient(
                colors: [Color(r: 77, g: 1, b: 87),
                         Color(r: 102, g: 12, b: 62)],
                startPoint: .top, endPoint: .bottom
            )
        }
    }
    
    var mainTextColor: Color {
        switch self.selectedTheme {
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 255/255, green: 220/255, blue: 44/255, alpha: 1) :
                UIColor(red: 255/255, green: 123/255, blue: 0/255, alpha: 1)
            })
        case .light:
            return .init(r: 255, g: 123, b: 0)
        case .dark:
            return .init(r: 255, g: 220, b: 44)
        }
    }
    
    var loadingTextColor: Color {
        switch self.selectedTheme {
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 234/255, green: 180/255, blue: 248/255, alpha: 1) :
                    .white
            })
        case .light:
            return .white
        case .dark:
            return .init(r: 234, g: 180, b: 248)
        }
    }
    
    var errorTextColor: Color {
        switch self.selectedTheme {
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 234/255, green: 180/255, blue: 248/255, alpha: 1) :
                    .black
            })
        case .light:
            return .black
        case .dark:
            return .init(r: 234, g: 180, b: 248)
        }
    }
    
    func errorBgColor(for systemScheme: ColorScheme) -> LinearGradient {
        switch self.selectedTheme {
        case .system:
            return systemScheme == .dark
            ? LinearGradient(colors: [
                Color(r: 169, g: 57, b: 218),
                Color(r: 78, g: 0, b: 113)],
                             startPoint: .top, endPoint: .bottom)
            : LinearGradient(colors: [
                Color(r: 235, g: 235, b: 235),
                Color(r: 206, g: 206, b: 206)],
                             startPoint: .top, endPoint: .bottom)
        case .light:
            return LinearGradient(colors: [
                Color(r: 235, g: 235, b: 235),
                Color(r: 206, g: 206, b: 206)],
                                  startPoint: .top, endPoint: .bottom)
        case .dark:
            return LinearGradient(colors: [
                Color(r: 169, g: 57, b: 218),
                Color(r: 78, g: 0, b: 113)],
                                  startPoint: .top, endPoint: .bottom)
        }
    }
    
    func themeBackgroundContainers(for systemScheme: ColorScheme) -> LinearGradient {
        switch self.selectedTheme {
        case .light:
            return LinearGradient(
                colors: [Color(r: 233, g: 219, b: 255),
                         Color(r: 246, g: 233, b: 255)],
                startPoint: .top, endPoint: .bottom
            )
        case .dark:
            return LinearGradient(
                colors: [Color(r: 108, g: 0, b: 123),
                         Color(r: 89, g: 0, b: 124)],
                startPoint: .top, endPoint: .bottom
            )
        case .system:
            return systemScheme == .dark
            ? LinearGradient(
                colors: [Color(r: 108, g: 0, b: 123),
                         Color(r: 89, g: 0, b: 124)],
                startPoint: .top, endPoint: .bottom
            )
            : LinearGradient(
                colors: [Color(r: 233, g: 219, b: 255),
                         Color(r: 246, g: 233, b: 255)],
                startPoint: .top, endPoint: .bottom
            )
        }
    }
    
    func customSettingsButtonBGcolor(for systemScheme: ColorScheme) -> LinearGradient {
        switch self.selectedTheme {
        case .light:
            return LinearGradient(
                colors: [Color(r: 122, g: 58, b: 214),
                         Color(r: 205, g: 61, b: 230)],
                startPoint: .top, endPoint: .bottom
            )
        case .dark:
            return LinearGradient(colors: [
                Color.init(r: 46, g: 15, b: 105),
                Color.init(r: 104, g: 11, b: 120)
            ], startPoint: .top, endPoint: .bottom)
        case .system:
            return systemScheme == .dark
            ? LinearGradient(colors: [
                Color.init(r: 46, g: 15, b: 105),
                Color.init(r: 104, g: 11, b: 120)
            ], startPoint: .top, endPoint: .bottom)
            : LinearGradient(
                colors: [Color(r: 122, g: 58, b: 214),
                         Color(r: 205, g: 61, b: 230)],
                startPoint: .top, endPoint: .bottom
            )
        }
    }
    
    func setCustomStrokeForSettingsButton() -> Color {
        switch self.selectedTheme{
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 64/255, green: 20/255, blue: 131/255, alpha: 1) :
                UIColor(red: 125/255, green: 56/255, blue: 255/255, alpha: 1)
            })
        case .light:
            return Color.init(r: 125, g: 56, b: 255)
        case .dark:
            return Color.init(r: 64, g: 20, b: 131)
        }
    }
}

extension Notification.Name {
    static let closeAllSheets = Notification.Name("closeAllSheets")
}
