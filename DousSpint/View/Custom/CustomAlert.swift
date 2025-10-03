//
//  CustomAlert.swift
//  DousSpint
//
//  Created by Никита on 02.10.2025.
//

import SwiftUI

struct CustomAlert: View {
    let actionPrimaryButton: () -> Void
    let actionSecondaryButton: () -> Void
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var systemScheme
    
    let title: String
    let description: String
    
    let isReset: Bool
    
    var body: some View {
        VStack{
            VStack(spacing: 0){
                Text(title)
                    .foregroundStyle(viewModel.buttonTextColor)
                    .font(.poppins(.medium, size: 24))
                
                Text(description)
                    .font(.poppins(.medium, size: 16))
                    .foregroundStyle(viewModel.buttonTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.top, 13)
                
                HStack{
                    CancelButton(title: "Cancel", action: {
                        actionSecondaryButton()
                    })
                    
                    if isReset{
                        ResetButton(title: "Reset", action: {
                            actionPrimaryButton()
                        })
                    }else{
                        ExportButton(title: "Export", action: {actionPrimaryButton() })
                    }
                }
                .padding(.horizontal)
                .padding(.top, 32)
            }
            .padding()
            .background(customBgColor(for: systemScheme))
            .cornerRadius(24)
            .overlay {
                RoundedRectangle(cornerRadius: 24)
                    .stroke(style: StrokeStyle(lineWidth: 1))
                    .foregroundColor(setCustomStrokeForSettingsButton())
            }
        }
    }
    
    private func setCustomStrokeForSettingsButton() -> Color {
        switch viewModel.selectedTheme{
        case .system:
            return Color(UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ?
                UIColor(red: 131/255, green: 29/255, blue: 142/255, alpha: 1) :
                UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1)
            })
        case .light:
            return Color.init(r: 167, g: 167, b: 167)
        case .dark:
            return Color.init(r: 131, g: 29, b: 142)
        }
    }
    
    private func customBgColor(for systemScheme: ColorScheme) -> LinearGradient {
        switch viewModel.selectedTheme{
        case .system:
            return systemScheme == .dark
            ? LinearGradient(colors: [
                Color(r: 77, g: 1, b: 87),
                Color(r: 102, g: 12, b: 62)
            ], startPoint: .top, endPoint: .bottom)
            : LinearGradient(colors: [
                Color(r: 240, g: 240, b: 240),
                Color(r: 209, g: 209, b: 209)
            ], startPoint: .top, endPoint: .bottom)
            
        case .light:
            return LinearGradient(colors: [
                Color(r: 240, g: 240, b: 240),
                Color(r: 209, g: 209, b: 209)
            ], startPoint: .top, endPoint: .bottom)
        case .dark:
            return LinearGradient(colors: [
                Color(r: 77, g: 1, b: 87),
                Color(r: 102, g: 12, b: 62)
            ], startPoint: .top, endPoint: .bottom)
        }
    }
}

#Preview {
    CustomAlert(actionPrimaryButton: { }, actionSecondaryButton: { }, title: "", description: "", isReset: true)
        .environmentObject(ViewModel())
}

struct CustomAlertExport: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CustomAlertExport()
        .environmentObject(ViewModel())
}
