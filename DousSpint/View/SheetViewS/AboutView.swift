//
//  AboutView.swift
//  DousSpint
//
//  Created by Никита on 02.10.2025.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.colorScheme) var systemScheme
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(viewModel.backgroundColor)
                .ignoresSafeArea()
            ZStack{
                VStack{
                    HStack(spacing: 14){
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image("arrowBack")
                        })
                        
                        
                        Text("About Dous Spint")
                            .font(.calistoga(size: 24))
                            .foregroundColor(viewModel.headerTextColor)
                        
                        Spacer()
                    }
                    .padding(.leading)
                    Spacer()
                }
                VStack(spacing: 48){
                    Spacer()
                    
                    VStack{
                        Image("logoWheel")
                            .resizable()
                            .frame(width: 49, height: 51)
                        
                        Image("name2lines")
                            .resizable()
                            .frame(width: 76, height: 52)
                            .padding(.top, 8)
                    }
                    
                    Text("Version: v1.0.0")
                        .foregroundColor(viewModel.buttonTextColor)
                    
                    Text("Daily spin challenges for fun & growth.")
                        .foregroundColor(viewModel.buttonTextColor)
                    
                    VStack(spacing: 12){
                        Button(action: {
                            
                        }, label: {
                            Text("Privacy Policy")
                                .foregroundColor(Color.init(r: 243, g: 0, b: 237))
                        })
                        
                        Button(action: {
                            
                        }, label: {
                            Text("Terms of Use")
                                .foregroundColor(Color.init(r: 243, g: 0, b: 237))
                        })
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    AboutView()
        .environmentObject(ViewModel())
}
