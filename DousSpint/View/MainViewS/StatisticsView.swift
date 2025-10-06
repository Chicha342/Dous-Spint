//
//  StatisticsView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var systemScheme
    
    private let weakOptions: [String] = ["Week", "Month", "All"]
    @State private var selectedOption: String = "Week"
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(viewModel.backgroundColor)
                .ignoresSafeArea(edges: .all)
            
            VStack(){
                Text("Statistics")
                    .font(.calistoga(size: 24))
                    .foregroundColor(viewModel.headerTextColor)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top)
                    .padding(.bottom)
                
                if viewModel.completedTasksCount == 0 {
                    VStack{
                        Spacer()
                        
                        Image("StatsImage")
                            .resizable()
                            .frame(width: 71, height: 61)
                        
                        Text("Complete your first task")
                            .font(.poppins(.medium, size: 20))
                            .foregroundColor(viewModel.buttonTextColor)
                        
                        Text("to see stats.")
                            .font(.poppins(.medium, size: 20))
                            .foregroundColor(viewModel.buttonTextColor)
                        
                        Spacer()
                    }
                }else {
                    ScrollView{
                        VStack(alignment: .leading){
                            HStack(alignment: .bottom, spacing: 16){
                                VStack(alignment: .leading){
                                    Text("Total tasks\ncompleted:")
                                        .font(.poppins(.regular, size: 16))
                                        .foregroundColor(viewModel.buttonTextColor)
                                    
                                    TaskStatisticContainer(str: "\(viewModel.completedTasksCount(for: selectedOption))")
                                }
                                VStack(alignment: .leading){
                                    Text("Streak days:")
                                        .font(.poppins(.regular, size: 16))
                                        .foregroundColor(viewModel.buttonTextColor)
                                    
                                    TaskStatisticContainer(str: "\(viewModel.currentStreak(for: selectedOption))")
                                    
                                }
                            }
                            .padding(.horizontal)
                            
                            
                            HStack(spacing: 8) {
                                ForEach(weakOptions, id: \.self) { option in
                                    DifficultyButton(
                                        title: option,
                                        isSelected: selectedOption == option,
                                        action: {
                                            withAnimation {
                                                selectedOption = option
                                            }
                                        }
                                    )
                                }
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(red: 164/255, green: 0/255, blue: 219/255),
                                            lineWidth: 1
                                    )
                            }
                            .padding()
                            
                            ZStack(alignment: .bottomLeading){
                                Text("Categories".uppercased())
                                    .font(.poppins(.medium, size: 12))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(viewModel.themeBackgroundContainers(for: systemScheme))
                                    .cornerRadius(5)
                                    .foregroundColor(viewModel.buttonTextColor)
                                    .padding(.top)
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(viewModel.themeBackgroundContainers(for: systemScheme))
                                    .frame(maxWidth: .infinity, maxHeight: 2)
                                    .cornerRadius(5)
                                    .padding(.leading, 2)
                            }
                            .padding(.horizontal)
                            
                            StatisticsCircle(selectedPeriod: selectedOption)
                            
                            
                            ZStack(alignment: .bottomLeading){
                                Text("Tasks completed per weekday".uppercased())
                                    .font(.poppins(.medium, size: 12))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(viewModel.themeBackgroundContainers(for: systemScheme))
                                    .cornerRadius(5)
                                    .foregroundColor(viewModel.buttonTextColor)
                                    .padding(.top)
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(viewModel.themeBackgroundContainers(for: systemScheme))
                                    .frame(maxWidth: .infinity, maxHeight: 2)
                                    .cornerRadius(5)
                                    .padding(.leading, 2)
                            }
                            .padding(.horizontal)
                            
                            StatisticsGraph(selectedPeriod: selectedOption)
                                .padding()
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    StatisticsView()
        .environmentObject(ViewModel())
        .colorScheme(.light)
}

#Preview {
    StatisticsView()
        .environmentObject(ViewModel())
        .colorScheme(.dark)
}
