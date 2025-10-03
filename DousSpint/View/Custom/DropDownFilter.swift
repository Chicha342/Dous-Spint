//
//  DropDownFilter.swift
//  DousSpint
//
//  Created by Никита on 03.10.2025.
//

import SwiftUI

struct DropdownFilter: View {
    let title: String
    let options: [String]
    @Binding var selection: String
    @State private var isExpanded = false
    
    @EnvironmentObject var settings: ViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text(selection)
                        .font(.poppins(.medium, size: 12))
                        .foregroundColor(customTextColor())
                    Spacer()
                    Image(isExpanded ? "chevronUp" : "chevronDown")
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                }
                .padding()
                .background(Color.clear)
                .clipShape(
                        RoundedCorner(
                            radius: 8,
                            corners: isExpanded ? [.topLeft, .topRight] : [.allCorners]
                        )
                    )
                    .overlay {
                        RoundedCorner(
                            radius: 8,
                            corners: isExpanded ? [.topLeft, .topRight] : [.allCorners]
                        )
                        .stroke(customStrokeColor(), lineWidth: 1)
                    }
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button {
                            selection = option
                            withAnimation {
                                isExpanded = false
                            }
                        } label: {
                            Text(option)
                                .font(.poppins(.medium, size: 12))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(selection == option ? customBg() : Color.clear)
                                .foregroundColor(selection == option ? customTextColorSelected() : customTextColor())
                                .overlay {
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color.init(r: 229, g: 54, b: 185), lineWidth: 1)
                                }
                        }
                    }
                }
                .background(Color.clear)
                .clipShape(RoundedCorner(radius: 12, corners: [.bottomLeft, .bottomRight]))
                .overlay {
                    RoundedCorner(radius: 12, corners: [.bottomLeft, .bottomRight])
                        .stroke(customStrokeColor(), lineWidth: 1)
                }
                
            }
        }
    }
    
    func customBg() -> Color{
        switch settings.selectedTheme {
        case .light:
            return .init(r: 249, g: 219, b: 255)
        case .dark:
            return .init(r: 229, g: 54, b: 185)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 229, g: 54, b: 185)) :
                UIColor(Color(r: 249, g: 219, b: 255))
            })
        }
    }
    
    func customTextColor() -> Color{
        switch settings.selectedTheme {
        case .light:
            return .init(r: 229, g: 123, b: 255)
        case .dark:
            return .init(r: 234, g: 180, b: 248)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 234, g: 180, b: 248)) :
                UIColor(Color(r: 229, g: 123, b: 255))
            })
        }
    }
    
    func customTextColorSelected() -> Color{
        switch settings.selectedTheme {
        case .light:
            return .init(r: 203, g: 37, b: 247)
        case .dark:
            return .init(r: 255, g: 235, b: 192)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 255, g: 235, b: 192)) :
                UIColor(Color(r: 203, g: 37, b: 247))
            })
        }
    }
    
    func customStrokeColor() -> Color{
        switch settings.selectedTheme {
        case .light:
            return .init(r: 212, g: 84, b: 255)
        case .dark:
            return .init(r: 229, g: 54, b: 185)
        case .system:
            return Color(UIColor { trait in
                trait.userInterfaceStyle == .dark ?
                UIColor(Color(r: 229, g: 54, b: 185)) :
                UIColor(Color(r: 212, g: 84, b: 255))
            })
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
