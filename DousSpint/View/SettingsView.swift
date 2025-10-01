//
//  SettingsView.swift
//  DousSpint
//
//  Created by Никита on 01.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var systemScheme
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(viewModel.backgroundColor)
                .ignoresSafeArea()
            VStack(alignment: .leading){
                HStack(spacing: 14){
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image("arrowBack")
                    })
                    
                    
                    Text("Settings")
                        .font(.calistoga(size: 24))
                        .foregroundColor(viewModel.mainTextColor)
                    
                    Spacer()
                }
                
                Text("Theme")
                    .font(.poppins(.medium, size: 12))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(viewModel.themeBackgroundContainers(for: systemScheme))
                    .cornerRadius(5)
                    .padding(.top)
                
                Button(action: {
                    withAnimation {
                        viewModel.changeTheme(.system)
                    }
                }, label: {
                    HStack{
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 24, height: 24)
                            .overlay {
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .fill(viewModel.selectedTheme == .system ? Color.init(r: 243, g: 0, b: 237) : Color.init(r: 185, g: 185, b: 185))
                                
                                if viewModel.selectedTheme == .system {
                                    Circle()
                                        .fill(Color.init(r: 243, g: 0, b: 237))
                                        .frame(width: 12, height: 12)
                                }
                            }
                        
                        Text("System")
                            .font(.poppins(.regular, size: 16))
                            .foregroundColor(viewModel.buttonTextColor)
                        
                        Spacer()
                    }
                })
                
                Button(action: {
                    withAnimation {
                        viewModel.changeTheme(.light)
                    }
                }, label: {
                    HStack{
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 24, height: 24)
                            .overlay {
                                ZStack{
                                    Circle()
                                        .stroke(style: StrokeStyle(lineWidth: 2))
                                        .fill((viewModel.selectedTheme == .light ? Color.init(r: 243, g: 0, b: 237) : Color.init(r: 185, g: 185, b: 185)))
                                    
                                    if viewModel.selectedTheme == .light  {
                                        Circle()
                                            .fill(Color.init(r: 243, g: 0, b: 237))
                                            .frame(width: 12, height: 12)
                                    }
                                }
                            }
                        
                        Text("Light")
                            .font(.poppins(.regular, size: 16))
                            .foregroundColor(viewModel.buttonTextColor)
                        
                        Spacer()
                    }
                })
                
                Button(action: {
                    withAnimation {
                        viewModel.changeTheme(.dark)
                    }
                }, label: {
                    HStack{
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 24, height: 24)
                            .overlay {
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .fill(viewModel.selectedTheme == .dark ? Color.init(r: 243, g: 0, b: 237) : Color.init(r: 185, g: 185, b: 185))
                                
                                if viewModel.selectedTheme == .dark {
                                    Circle()
                                        .fill(Color.init(r: 243, g: 0, b: 237))
                                        .frame(width: 12, height: 12)
                                }
                            }
                        
                        Text("Dark")
                            .font(.poppins(.regular, size: 16))
                            .foregroundColor(viewModel.buttonTextColor)
                        
                        Spacer()
                    }
                })
                
                Spacer()
            }
            .padding(.leading)
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ViewModel())
}

#Preview {
    SettingsView()
        .environmentObject(ViewModel())
        .colorScheme(.dark)
}
