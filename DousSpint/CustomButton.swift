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
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .font(.calistoga(size: 20))
                .shadow(radius: 0, x: 0, y: 2)
                
                .foregroundColor(.init(r: 255, g: 235, b: 192))
                .frame(maxWidth: 358, maxHeight: 56)
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

#Preview {
    VStack(spacing: 20) {
        MainCustomButton(title: "Next", action: {})
    }
    .padding()
}
