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
    
    @State private var isExportData = false
    @State private var resetProgress = false
    @State private var isShowAbout = false
    @State private var isAutoStartNext = false
    @State private var isHaptics = false
    
    @State private var isPurchasing = false
    @State private var purchaseErrorMessage: String? = nil
    @State private var showPurchaseAlert = false
    
    @EnvironmentObject var storeManager: StoreManager
    
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
                        .foregroundColor(viewModel.headerTextColor)
                    
                    Spacer()
                }
                .padding(.top)
                .padding(.leading)
                
                ScrollView{
                    VStack(alignment: .leading){
                        Text("THEME")
                            .font(.poppins(.medium, size: 12))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(viewModel.themeBackgroundContainers(for: systemScheme))
                            .cornerRadius(5)
                            .foregroundColor(viewModel.buttonTextColor)
                            .padding(.top)
                        
                        VStack{
                            //                            Button(action: {
                            //                                withAnimation {
                            //                                    viewModel.changeTheme(.system)
                            //                                }
                            //                            }, label: {
                            //                                HStack{
                            //                                    Circle()
                            //                                        .fill(Color.clear)
                            //                                        .frame(width: 24, height: 24)
                            //                                        .overlay {
                            //                                            Circle()
                            //                                                .stroke(style: StrokeStyle(lineWidth: 2))
                            //                                                .fill(viewModel.selectedTheme == .system ? Color.init(r: 243, g: 0, b: 237) : Color.init(r: 185, g: 185, b: 185))
                            //
                            //                                            if viewModel.selectedTheme == .system {
                            //                                                Circle()
                            //                                                    .fill(Color.init(r: 243, g: 0, b: 237))
                            //                                                    .frame(width: 12, height: 12)
                            //                                            }
                            //                                        }
                            //
                            //                                    Text("System")
                            //                                        .font(.poppins(.regular, size: 16))
                            //                                        .foregroundColor(viewModel.buttonTextColor)
                            //
                            //                                    Spacer()
                            //                                }
                            //                            })
                            
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
                            
                            if storeManager.purchasedDarkTheme{
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
                            }else{
                                Button(action: {
                                    withAnimation {
                                        purchaseProduct(id: "dark_Theme_unlock")
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
                                            }
                                        
                                        Text("Dark (Unlock 0.99$)")
                                            .font(.poppins(.regular, size: 16))
                                            .foregroundColor(viewModel.buttonTextColor)
                                        
                                        Spacer()
                                    }
                                })
                            }
                            
                        }
                        
                        Text("PREFERENCES")
                            .font(.poppins(.medium, size: 12))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .foregroundColor(viewModel.buttonTextColor)
                            .background(viewModel.themeBackgroundContainers(for: systemScheme))
                            .cornerRadius(5)
                            .padding(.top)
                        
                        HStack{
                            Text("Daily spin limit")
                                .font(.poppins(.regular, size: 16))
                                .foregroundColor(viewModel.buttonTextColor)
                            
                            Spacer()
                            
                            Text("\(viewModel.spinsLeftToday)")
                                .font(.poppins(.medium, size: 20))
                                .foregroundColor(Color.init(r: 243, g: 0, b: 237))
                        }
                        .padding(.trailing)
                        
                        HStack{
                            Text("Auto-start next")
                                .font(.poppins(.regular, size: 16))
                                .foregroundColor(viewModel.buttonTextColor)
                            
                            Spacer()
                            
                            Toggle(isOn: $isAutoStartNext, label: {  })
                                .frame(width: 51, height: 31)
                                .toggleStyle(.switch)
                                .tint(Color.init(r: 243, g: 0, b: 237))
                        }
                        .padding(.trailing)
                        
                        HStack{
                            Text("Haptics")
                                .font(.poppins(.regular, size: 16))
                                .foregroundColor(viewModel.buttonTextColor)
                            
                            Spacer()
                            
                            Toggle(isOn: $isHaptics, label: {  })
                                .frame(width: 51, height: 31)
                                .toggleStyle(.switch)
                                .tint(Color.init(r: 243, g: 0, b: 237))
                        }
                        .padding(.trailing)
                        
                        Text("DATA")
                            .font(.poppins(.medium, size: 12))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .foregroundColor(viewModel.buttonTextColor)
                            .background(viewModel.themeBackgroundContainers(for: systemScheme))
                            .cornerRadius(5)
                            .padding(.top)
                        
                        VStack{
                            if storeManager.purchasedExport {
                                ExportButton(title: "Export History", action: {
                                    isExportData = true
                                })
                            }else {
                                ExportButton(title: "Export History (Unlock 1.99$)", action: {
                                    purchaseProduct(id: "export_data_unlock")
                                })
                            }
                            
                            ResetButton(title: "Reset Progress", action: {
                                resetProgress = true
                            })
                        }
                        .padding(.trailing)
                        
                        Button(action: {
                            isShowAbout = true
                        }, label: {
                            VStack(alignment: .leading){
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.init(r: 246, g: 64, b: 241))
                                    .frame(maxWidth: .infinity, maxHeight: 1)
                                
                                HStack{
                                    Text("About")
                                        .padding(.vertical, 12)
                                        .font(.poppins(.regular, size: 16))
                                        .foregroundColor(viewModel.buttonTextColor)
                                    
                                    Spacer()
                                    
                                    Image("arrowRight")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.init(r: 246, g: 64, b: 241))
                                    .frame(maxWidth: .infinity, maxHeight: 1)
                            }
                            
                        })
                        .padding(.top, 56)
                        .padding(.trailing)
                        
                        Spacer()
                    }
                    .padding(.leading)
                }
            }
            
            if isExportData {
                CustomAlert(
                    actionPrimaryButton: {
                        viewModel.exportDataToCSV()
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isExportData = false
                        }
                    },
                    actionSecondaryButton: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isExportData = false
                        }
                    },
                    title: "Export History?",
                    description: "Your history will be saved as a CSV file. Proceed with export?",
                    isReset: false
                )
                .transition(.opacity)
                .zIndex(1)
                .padding(.horizontal, 8)
            }
            
            if resetProgress {
                CustomAlert(
                    actionPrimaryButton: {
                        viewModel.resetAllProgress()
                        resetProgress = false
                    },
                    actionSecondaryButton: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            resetProgress = false
                        }
                    },
                    title: "Reset Progress?",
                    description: "This will permanently erase all your stats and history. Are you sure?",
                    isReset: true
                )
                .transition(.opacity)
                .zIndex(1)
                .padding(.horizontal, 8)
            }
            
            
            if isPurchasing {
                VStack{
                    ProgressView()
                    
                    Text("Loading...")
                        .font(.poppins(.regular, size: 16))
                        .foregroundColor(viewModel.loadingTextColor)
                }
                .padding(.bottom, 60)
            }
            
        }
        .animation(.easeInOut(duration: 0.3), value: isExportData)
        .animation(.easeInOut(duration: 0.3), value: resetProgress)
        
        .fullScreenCover(isPresented: $isShowAbout) {
            AboutView()
        }
        .alert("Purchase Failed", isPresented: $showPurchaseAlert, actions: {
            Button("OK", role: .cancel) {}
        }, message: {
            Text(purchaseErrorMessage ?? "Unknown error")
        })
        .onAppear {
            Task { await storeManager.fetchProducts() }
        }
    }
    
    private func purchaseProduct(id: String) {
        guard let product = storeManager.products.first(where: { $0.id == id }) else { return }
        isPurchasing = true
        Task {
            do {
                try await storeManager.purchase(product)
            } catch {
                purchaseErrorMessage = error.localizedDescription
                showPurchaseAlert = true
            }
            isPurchasing = false
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(ViewModel())
        .environmentObject(StoreManager())
}
