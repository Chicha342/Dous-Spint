//
//  SwipeDelete.swift
//  DousSpint
//
//  Created by Никита on 03.10.2025.
//

import SwiftUI

struct SwipeToDeleteRow<Content: View>: View {
    let content: Content
    let onDelete: () -> Void
    
    @GestureState private var dragOffset: CGFloat = 0
    @State private var offset: CGFloat = 0
    @State private var isDeleted = false
    
    init(@ViewBuilder content: () -> Content, onDelete: @escaping () -> Void) {
        self.content = content()
        self.onDelete = onDelete
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                Spacer()
                Image("trashImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: 165)
            .background(
                LinearGradient(
                    colors: [Color(r: 240, g: 0, b: 0), Color(r: 113, g: 13, b: 13)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .cornerRadius(24)
            .opacity(isDeleted ? 0 : 1)
            
            content
                .offset(x: offset + (dragOffset < 0 ? dragOffset : 0))
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            if value.translation.width < 0 {
                                state = value.translation.width
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < -150 {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    offset = -500
                                    isDeleted = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    onDelete()
                                }
                            } else {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                    offset = 0
                                }
                            }
                        }
                )
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: dragOffset)
                .opacity(isDeleted ? 0 : 1)
        }
        .padding(.horizontal)
    }
}
