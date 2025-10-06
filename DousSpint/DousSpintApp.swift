//
//  DousSpintApp.swift
//  DousSpint
//
//  Created by Никита on 29.09.2025.
//

import SwiftUI

@main
struct DousSpintApp: App {
    @StateObject var viewModel = ViewModel()
    @StateObject var storeManager = StoreManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(storeManager)
        }
    }
}
