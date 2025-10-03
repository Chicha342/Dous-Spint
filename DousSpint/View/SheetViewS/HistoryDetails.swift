//
//  HistoryDetails.swift
//  DousSpint
//
//  Created by Никита on 03.10.2025.
//

import SwiftUI

struct HistoryDetails: View {
    @EnvironmentObject var settings: ViewModel
    @Environment(\.colorScheme) var systemScheme
    @Environment(\.dismiss) var dismiss
    
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
    
    var buttonTextColor: Color {
        switch settings.selectedTheme {
        case .light:
            return .init(r: 203, g: 37, b: 247)
        case .dark:
            return .init(r: 234, g: 180, b: 248)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 234, g: 180, b: 248)) :
                UIColor(Color(r: 203, g: 37, b: 247))
            })
        }
    }
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(settings.backgroundColor)
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                HStack(spacing: 14){
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image("arrowBack")
                    })
                    
                    
                    Text("History")
                        .font(.calistoga(size: 24))
                        .foregroundColor(settings.headerTextColor)
                        .lineLimit(1)
                }
                .padding(.top)
                .padding(.horizontal)
                
                ScrollView{
                    VStack(alignment: .leading, spacing: 12){
                        Text(task.title)
                            .font(.calistoga(size: 34))
                            .foregroundColor(settings.buttonTextColor)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        Text(formatDate(result.completedAt ?? result.date))
                            .font(.poppins(.medium, size: 16))
                            .foregroundColor(buttonTextColor)
                        
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
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
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
    HistoryDetails(result: SpinResult(id: UUID(),
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
