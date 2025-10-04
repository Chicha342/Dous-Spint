//
//  Statistics.swift
//  DousSpint
//
//  Created by Никита on 04.10.2025.
//

import SwiftUI
import Charts

struct StatisticsCircle: View {
    @EnvironmentObject var viewModel: ViewModel
    let selectedPeriod: String
    
    private let categoryColors: [String: Color] = [
        "Body": Color(r: 255, g: 195, b: 0),
        "Mind": Color(r: 234, g: 100, b: 213),
        "Soul": Color(r: 0, g: 220, b: 225),
        "Connect": Color(r: 226, g: 18, b: 105),
        "Create": Color(r: 86, g: 12, b: 173)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // MARK: - Pie Chart with Legend
                HStack(alignment: .top, spacing: 20) {
                    VStack {
                        Chart {
                            ForEach(categoryStats, id: \.key) { category, count in
                                SectorMark(
                                    angle: .value("Tasks", count),
                                    innerRadius: .ratio(0),
                                    angularInset: 0
                                )
                                .foregroundStyle(categoryColors[category] ?? .gray)
                                .annotation(position: .overlay) {
                                    Text("\(percentage(for: count))%")
                                        .font(.poppins(.regular, size: 12))
                                        .foregroundColor(.white)
                                        .padding(4)
                                        .background {
                                            Color(r: 79, g: 79, b: 79, alpha: 0.25)
                                        }
                                        .cornerRadius(5)
                                }
                            }
                        }
                        .frame(height: 200)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(categoryStats, id: \.key) { category, count in
                            HStack(spacing: 17) {
                                Circle()
                                    .fill(categoryColors[category] ?? .gray)
                                    .frame(width: 18, height: 18)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(category)
                                        .font(.poppins(.regular, size: 16))
                                        .foregroundColor(viewModel.buttonTextColor)
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                }
            }
            .padding()
        }
    }
    
    // MARK: - Computed stats
    private var categoryStats: [(key: String, value: Int)] {
        return viewModel.categoryStats(for: selectedPeriod)
    }
    
    private var totalTasks: Int {
        categoryStats.reduce(0) { $0 + $1.value }
    }
    
    private func percentage(for count: Int) -> Int {
        guard totalTasks > 0 else { return 0 }
        return Int((Double(count) / Double(totalTasks)) * 100)
    }
}


//#Preview {
//    StatisticsCircle()
//        .environmentObject(ViewModel())
//}

struct StatisticsGraph: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var systemScheme
    let selectedPeriod: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Chart {
                ForEach(weeklyStats, id: \.day) { item in
                    BarMark(
                        x: .value("Day", item.day),
                        y: .value("Count", item.count)
                    )
                    .foregroundStyle(LinearGradient(
                        colors: [
                            Color(r: 254, g: 1, b: 91),
                            Color(r: 250, g: 240, b: 5)
                        ],
                        startPoint: .bottom,
                        endPoint: .top
                    ))
                    .cornerRadius(8)
                    
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) {
                    AxisGridLine()
                        .foregroundStyle(viewModel.themeBackgroundContainers(for: systemScheme))
                        .font(.poppins(.regular, size: 12))
                    AxisTick()
                        .foregroundStyle(viewModel.themeBackgroundContainers(for: systemScheme))
                        .font(.poppins(.regular, size: 12))
                    AxisValueLabel()
                        .font(.poppins(.regular, size: 12))
                        .foregroundStyle(viewModel.buttonTextColor)
                    
                }
            }
            .chartXAxis {
                AxisMarks {
                    AxisValueLabel()
                        .font(.poppins(.regular, size: 12))
                        .foregroundStyle(viewModel.buttonTextColor)
                    
                    AxisGridLine()
                        .foregroundStyle(viewModel.buttonTextColor.opacity(0.3))
                }
            }
            .frame(height: 200)
        }
    }
    
    private var weeklyStats: [WeekStat] {
            return viewModel.weeklyStats(for: selectedPeriod)
        }
        
        struct WeekStat {
            let day: String
            let count: Int
        }
}

//#Preview(body: {
//    StatisticsGraph()
//        .environmentObject(ViewModel())
//})
