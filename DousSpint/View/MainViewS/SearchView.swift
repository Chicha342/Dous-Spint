//
//  SearchView.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var settings: ViewModel
    @Environment(\.colorScheme) var systemScheme
    
    @State private var isLoading = false
    @State private var isShowList: Bool = false
    
    private let timeOptions = ["Up to 2 min", "Up to 5 min", "Up to 10 min"]
    private let difficultyOptions = ["Easy", "Medium", "Hard"]
    private var categories: [CategoryButton] {
        [
            CategoryButton(title: "All", action: {
                settings.searchFilters.category = "All"
            }),
            CategoryButton(title: "Body", action: {
                settings.searchFilters.category = "Body"
            }),
            CategoryButton(title: "Mind", action: {
                settings.searchFilters.category = "Mind"
            }),
            CategoryButton(title: "Soul", action: {
                settings.searchFilters.category = "Soul"
            }),
            CategoryButton(title: "Connect", action: {
                settings.searchFilters.category = "Connect"
            }),
            CategoryButton(title: "Create", action: {
                settings.searchFilters.category = "Create"
            })
        ]
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(settings.backgroundColor)
                .ignoresSafeArea(edges: .all)
            
            VStack(alignment: .leading){
                Text("Search")
                    .font(.calistoga(size: 24))
                    .foregroundColor(settings.headerTextColor)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top)
                
                // MARK: Search Field
                ZStack{
                    HStack{
                        if settings.searchFilters.searchText.isEmpty{
                            Image("SearchSelected")
                            
                            
                            Text("Search")
                                .foregroundColor(Color(red: 164/255, green: 47/255, blue: 194/255))
                            
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            settings.searchFilters.searchText = " "
                        }, label: {
                            Image("x")
                                .resizable()
                                .frame(width: 15, height: 15)
                        })
                        .zIndex(1)
                        
                    }
                    .padding(.horizontal)
                    
                    TextField("", text: $settings.searchFilters.searchText)
                        .foregroundColor(Color(red: 164/255, green: 47/255, blue: 194/255))
                        .padding()
                        .frame(height: 48)
                        .background{
                            Color.clear
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.init(r: 243, g: 0, b: 237), lineWidth: 1)
                        }
                        .zIndex(0)
                }
                .padding(.horizontal)
                
                ScrollView{
                    VStack(alignment: .leading){
                        // MARK: Categories
                        Text("Сategories".uppercased())
                            .font(.poppins(.regular, size: 12))
                            .foregroundColor(settings.buttonTextColor)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 6), count: 3), spacing: 6) {
                            ForEach(categories, id: \.title) { item in
                                SecondCustomButton(title: item.title,
                                                   action: item.action,
                                                   isActive: settings.searchFilters.category == item.title)
                            }
                        }
                        .padding(.horizontal)
                        
                        // MARK: Difficulty
                        VStack(alignment: .leading){
                            Text("Difficulty".uppercased())
                                .font(.poppins(.regular, size: 12))
                                .foregroundColor(settings.buttonTextColor)
                                .padding(.top)
                                .padding(.horizontal)
                            
                            HStack(spacing: 8) {
                                ForEach(difficultyOptions, id: \.self) { difficulty in
                                    DifficultyButton(
                                        title: difficulty,
                                        isSelected: settings.searchFilters.difficulty == difficulty,
                                        action: {
                                            withAnimation {
                                                settings.searchFilters.difficulty = difficulty
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
                            .padding(.horizontal)
                        }
                        
                        // MARK: Time Filter
                        VStack(alignment: .leading){
                            Text("Time".uppercased())
                                .font(.poppins(.regular, size: 12))
                                .foregroundColor(settings.buttonTextColor)
                                .padding(.top)
                            
                            ForEach(timeOptions, id: \.self) { time in
                                Button(action: {
                                    withAnimation { settings.searchFilters.time = time }
                                }, label: {
                                    HStack{
                                        Circle()
                                            .fill(Color.clear)
                                            .frame(width: 24, height: 24)
                                            .overlay {
                                                Circle()
                                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                                    .fill(settings.searchFilters.time == time ? Color(red: 243/255, green: 0/255, blue: 237/255) : Color(red: 185/255, green: 185/255, blue: 185/255))
                                                
                                                if settings.searchFilters.time == time {
                                                    Circle()
                                                        .fill(Color(red: 243/255, green: 0/255, blue: 237/255))
                                                        .frame(width: 12, height: 12)
                                                }
                                            }
                                        
                                        Text(time)
                                            .font(.poppins(.regular, size: 16))
                                            .foregroundColor(settings.buttonTextColor)
                                        
                                        Spacer()
                                    }
                                })
                            }
                        }
                        .padding(.horizontal)
                        
                        //MARK: - RecentSearches
                        if !settings.recentSearchesArray.isEmpty {
                            
                        Text("Recent searches".uppercased())
                            .font(.poppins(.regular, size: 12))
                            .foregroundColor(settings.buttonTextColor)
                            .padding(.top)
                            .padding(.horizontal)
                        
                        
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                                ForEach(settings.recentSearchesArray, id: \.self) { search in
                                    RecentSercesContainer(text: search)
                                        .onTapGesture {
                                            settings.searchFilters.searchText = search
                                        }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 8)
                        }
                        
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 15){
                        Spacer()
                        
                        SecondMainButton(title: "Clear filter", action: {
                            settings.clearSearchFilters()
                        }, height: 56).opacity(isLoading ? 0.6 : 1)
                        
                        MainCustomButton(title: "Apply", action: {
                            isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                isLoading = false
                                settings.applyCurrentFilters()
                                isShowList = true
                                if !settings.searchFilters.searchText.isEmpty{
                                    settings.recentSearchesArray.append(settings.searchFilters.searchText)
                                }
                            }
                        }, height: 56).opacity(isLoading ? 0.6 : 1)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .overlay(overlayContent())
            }
        }
        .fullScreenCover(isPresented: $isShowList) {
            SearchList()
                .environmentObject(settings)
        }
    }
    
    private func overlayContent() -> some View {
        ZStack{
            if isLoading == true {
                VStack{
                    ProgressView()
                    
                    Text("Loading...")
                        .font(.poppins(.regular, size: 16))
                        .foregroundColor(settings.buttonTextColor)
                }
                .padding(.bottom, 40)
                
            }
        }
        
    }
    
}

#Preview {
    SearchView()
        .environmentObject(ViewModel())
}
