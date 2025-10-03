//
//  HistoryContainer.swift
//  DousSpint
//
//  Created by Никита on 03.10.2025.
//

import SwiftUI

struct HistoryContainer: View {
    @EnvironmentObject var settings: ViewModel
    @Environment(\.colorScheme) var systemScheme
    
    let result: SpinResult
    let task: TaskItem
    
    private var statusColor: Color {
        switch result.status {
        case .completed:
            return .init(r: 138, g: 169, b: 108)
        case .skipped:
            return .gray
        default:
            return .gray
        }
    }
    
    private var paddingStatus: Int {
        switch result.status {
        case .completed:
            return 0
        case .skipped:
            return 2
        default:
            return 2
        }
        
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(formatDate(result.completedAt ?? result.date))
                .font(.poppins(.medium, size: 12))
                .foregroundColor(settings.buttonTextColor)
            
            
            Text(task.title)
                .font(.calistoga(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(settings.buttonTextColor)
                .padding(.top, 1)
                .lineLimit(1)
                
            
            HStack(spacing: 4){
                if paddingStatus == 0 {
                    Image("completedIcon")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                
                Text(result.status.rawValue.capitalized)
                    .foregroundStyle(statusColor)
                    .font(.poppins(.medium, size: 12))
                    .padding(.top, CGFloat(paddingStatus))
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
    
    private func themeBackgroundButton(for systemScheme: ColorScheme) -> LinearGradient {
        switch settings.selectedTheme {
        case .light:
            return LinearGradient(
                colors: [Color(r: 233, g: 219, b: 255),
                         Color(r: 246, g: 203, b: 255)],
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
                         Color(r: 246, g: 203, b: 255)],
                startPoint: .top, endPoint: .bottom
            )
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(date) {
            formatter.dateFormat = "'Today at' HH:mm"
        } else if Calendar.current.isDateInYesterday(date) {
            formatter.dateFormat = "'Yesterday at' HH:mm"
        } else {
            formatter.dateFormat = "MMM d 'at' HH:mm"
        }
        return formatter.string(from: date)
    }
    
    private func formatTimeSpent(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        
        if minutes > 0 {
            return "\(minutes)m \(seconds)s"
        } else {
            return "\(seconds)s"
        }
    }
}

#Preview {
    HistoryContainer(result: SpinResult(id: UUID(),
                                        taskId: 5,
                                        date: Date(),
                                        status: .completed), task: TaskItem(
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
