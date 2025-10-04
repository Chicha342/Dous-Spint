//
//  CustomButton.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

import SwiftUI

struct MainCustomButton: View {
    let title: String
    let action: () -> Void
    
    let height: Int?
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .font(.calistoga(size: 20))
                .shadow(radius: 0, x: 0, y: 2)
                .foregroundColor(.init(r: 255, g: 235, b: 192))
                .frame(maxWidth: .infinity, maxHeight: CGFloat(height ?? 56))
                .background{
                    LinearGradient(colors:
                                    [Color.init(r: 245, g: 117, b: 127),
                                     Color.init(r: 244, g: 137, b: 27),
                                     Color.init(r: 244, g: 107, b: 6),
                                     Color.init(r: 213, g: 26, b: 8),
                                     Color.init(r: 169, g: 7, b: 4),
                                     Color.init(r: 169, g: 7, b: 4),
                                     Color.init(r: 213, g: 66, b: 27),
                                     Color.init(r: 222, g: 66, b: 23)],
                                   startPoint: .top,
                                   endPoint: .bottom)
                }
                .cornerRadius(60)
                .overlay {
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color.init(r: 190, g: 50, b: 17), lineWidth: 1)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color.init(r: 255, g: 227, b: 53), lineWidth: 4)
                }
        }
    }
}

struct SecondMainButton: View {
    let title: String
    let action: () -> Void
    
    let height: Int?
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .font(.calistoga(size: 20))
                .shadow(radius: 0, x: 0, y: 2)
                .foregroundColor(.init(r: 234, g: 180, b: 248))
                .frame(maxWidth: .infinity, maxHeight: CGFloat(height ?? 56))
                .background{
                    LinearGradient(colors:
                                    [Color.init(r: 46, g: 15, b: 105),
                                     Color.init(r: 104, g: 11, b: 120)],
                                   startPoint: .top,
                                   endPoint: .bottom)
                }
                .cornerRadius(60)
                .overlay {
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color.init(r: 64, g: 20, b: 131), lineWidth: 4)
                }
        }
    }
}

#Preview {
    VStack(spacing: 0) {
        SecondMainButton(title: "Second", action: {}, height: 56)
    }
    .padding()
}

struct SecondCustomButton: View {
    @EnvironmentObject var settings: ViewModel
    @Environment(\.colorScheme) var systemScheme
    
    let title: String
    let action: () -> Void
    let isActive: Bool
    
    var body: some View {
        VStack{
            Button(action: {
                action()
            }){
                Text(title)
                    .padding()
                    .font(.poppins(.regular, size: 16))
                    .foregroundColor(isActive ?  settings.selectedButtonTextColor : settings.buttonTextColor)
                    .frame(maxWidth: 358, maxHeight: 56)
                    .background(isActive ? settings.selectedBg(for: systemScheme) : settings.themeBackgroundButton(for: systemScheme))
                    .cornerRadius(8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.init(r: 207, g: 65, b: 255), lineWidth: 1)
                    }
            }
        }
        
        
    }
}

#Preview {
    VStack(spacing: 10) {
        HStack{
            SecondCustomButton(title: "All", action: {}, isActive: false)
                .environmentObject(ViewModel())
                .colorScheme(.light)
        }
    }
    .padding()
}

struct DetailsCustomButton: View {
    @EnvironmentObject var settings: ViewModel
    @Environment(\.colorScheme) var systemScheme
    
    let title: String
    let action: () -> Void
    
    let with: Int
    let height: Int
    
    var buttonTextColor: Color {
        switch settings.selectedTheme {
        case .light:
            return .init(r: 203, g: 37, b: 247)
        case .dark:
            return .init(r: 230, g: 180, b: 248)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 230, g: 180, b: 248)) : UIColor(Color(r: 203, g: 37, b: 247))
            })
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack{
                Text(title)
                    .font(.calistoga(size: 17))
                    .foregroundStyle(buttonTextColor)
                
                Spacer()
                
                Image("arrayRight")
                    .resizable()
                    .frame(width: 18, height: 18)
                
            }
            .frame(width: CGFloat(with), height: CGFloat(height))
            .padding(.horizontal)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 60)
                    .stroke(Color.init(r: 203, g: 37, b: 247), lineWidth: 1)
                
            })
            
            
        }
    }
}

#Preview{
    DetailsCustomButton(title: "Details", action: { }, with: 60, height: 44)
        .environmentObject(ViewModel())
}


struct ResetButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .padding()
                .foregroundColor(Color.init(r: 255, g: 187, b: 187))
                .frame(maxWidth: .infinity)
                .shadow(radius: 1, x: 0, y: 2)
                .font(.calistoga(size: 20))
                .background{
                    LinearGradient(colors: [
                        Color.init(r: 136, g: 0, b: 0),
                        Color.init(r: 199, g: 0, b: 0)
                    ], startPoint: .top, endPoint: .bottom)
                }
                .cornerRadius(60)
                .overlay {
                    RoundedRectangle(cornerRadius: 60)
                        .stroke(Color.init(r: 255, g: 27, b: 27), lineWidth: 2)
                }
        })
    }
}

#Preview{
    ResetButton(title: "Reset Progress", action: { })
        .environmentObject(ViewModel())
}


struct ExportButton: View {
    let title: String
    let action: () -> Void
    @Environment(\.colorScheme) var systemScheme
    @EnvironmentObject var settings: ViewModel
    
    var body: some View {
        VStack{
            Button(action: {
                action()
            }, label: {
                Text(title)
                    .padding()
                    .foregroundColor(Color.init(r: 234, g: 180, b: 248))
                    .frame(maxWidth: .infinity)
                    .shadow(radius: 1, x: 0, y: 2)
                    .font(.calistoga(size: 20))
                    .background(settings.customSettingsButtonBGcolor(for: systemScheme))
                    .cornerRadius(60)
                    .overlay {
                        RoundedRectangle(cornerRadius: 60)
                            .stroke(settings.setCustomStrokeForSettingsButton(), lineWidth: 2)
                    }
            })
        }
    }
}

#Preview{
    ExportButton(title: "Export History", action: { })
        .environmentObject(ViewModel())
}

struct CancelButton: View {
    let title: String
    let action: () -> Void
    @Environment(\.colorScheme) var systemScheme
    @EnvironmentObject var settings: ViewModel
    
    var body: some View {
        VStack{
            Button(action: {
                action()
            }, label: {
                Text(title)
                    .padding()
                    .foregroundColor(Color.init(r: 225, g: 225, b: 225))
                    .frame(maxWidth: .infinity)
                    .shadow(radius: 1, x: 0, y: 2)
                    .font(.calistoga(size: 20))
                    .background{
                        LinearGradient(colors: [
                            Color.init(r: 134, g: 134, b: 134),
                            Color.init(r: 193, g: 193, b: 193)
                        ], startPoint: .top, endPoint: .bottom)
                    }
                    .cornerRadius(60)
                    .overlay {
                        RoundedRectangle(cornerRadius: 60)
                            .stroke(Color.init(r: 140, g: 140, b: 140), lineWidth: 2)
                    }
            })
        }
    }
}

#Preview{
    CancelButton(title: "Export History", action: { })
        .environmentObject(ViewModel())
}


struct SkipCuptomButton: View {
    let title: String
    let action: () -> Void
    @Environment(\.colorScheme) var systemScheme
    @EnvironmentObject var settings: ViewModel
    
    var body: some View {
        VStack{
            Button(action: {
                action()
            }, label: {
                Text(title)
                    .font(.calistoga(size: 20))
                    .foregroundStyle(settings.skipButtonColor)
                    .padding()
                    .cornerRadius(60)
                    .frame(maxWidth: .infinity, maxHeight: 56)
                    .overlay {
                        RoundedRectangle(cornerRadius: 60)
                            .stroke(settings.skipButtonColor, lineWidth: 3)
                    }
            })
        }
    }
}

#Preview(body: {
    SkipCuptomButton(title: "Skip", action: {
        
    })
    .environmentObject(ViewModel())
})


struct DifficultyButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    @EnvironmentObject var settings: ViewModel
    @Environment(\.colorScheme) var systemScheme
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.poppins(.regular, size: 16))
                .foregroundColor(isSelected ? .white : Color(red: 185/255, green: 185/255, blue: 185/255))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    ZStack {
                        LinearGradient(
                            colors: [Color.clear, Color.clear],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        
                        customBg()
                            .opacity(isSelected ? 1 : 0)
                    }
                )
                .cornerRadius(8)
        }
        .animation(.easeInOut(duration: 0.3), value: isSelected)
    }
    
    private func customBg() -> LinearGradient {
        switch settings.selectedTheme {
        case .system:
            return systemScheme == .dark
            ? LinearGradient(
                colors: [Color(r: 164, g: 0, b: 219),
                         Color(r: 87, g: 0, b: 117)],
                startPoint: .top, endPoint: .bottom
            )
            : LinearGradient(
                colors: [Color(r: 232, g: 163, b: 255),
                         Color(r: 204, g: 54, b: 255)],
                startPoint: .top, endPoint: .bottom
            )
        case .light:
            return LinearGradient(
                colors: [Color(r: 232, g: 163, b: 255),
                         Color(r: 204, g: 54, b: 255)],
                startPoint: .top, endPoint: .bottom
            )
        case .dark:
            return LinearGradient(
                colors: [Color(r: 164, g: 0, b: 219),
                         Color(r: 87, g: 0, b: 117)],
                startPoint: .top, endPoint: .bottom
            )
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(ViewModel())
}
