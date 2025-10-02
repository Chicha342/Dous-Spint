//
//  CustomHeader.swift
//  DousSpint
//
//  Created by Никита on 01.10.2025.
//

import SwiftUI

struct CustomHeader: View {
    @EnvironmentObject var settingsViewModel: ViewModel
    
    var body: some View {
        ZStack{
            Image("headerLogo")
                .resizable()
                .frame(width: 31, height: 44)
            
            HStack(){
                Spacer()
                
                Button(action: {
                    settingsViewModel.showSettings = true
                }, label: {
                    Image("settingsIcon")
                        .padding(.trailing, 16)
                })
            }
        }
        .background(settingsViewModel.backgroundColor)
    }
}

#Preview {
    CustomHeader()
        .environmentObject(ViewModel())
}
