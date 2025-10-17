//
//  DousSpintApp.swift
//  DousSpint
//
//  Created by Никита on 29.09.2025.
//

import SwiftUI
import StoreKit
import OneSignalFramework

@main
struct DousSpintApp: App {
    @StateObject var viewModel = ViewModel()
    @StateObject var storeManager = StoreManager()
    @StateObject var containerViewModel = ContainerViewModelDS()

    var body: some Scene {
        WindowGroup {
            RootViewDS()
                .environmentObject(viewModel)
                .environmentObject(storeManager)
                .environmentObject(containerViewModel)
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func applicationWillTerminate(_ application: UIApplication) {
//        SKPaymentQueue.default().remove(StoreManager.shared)
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
//        SKPaymentQueue.default().add(StoreManager.shared)
        
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        OneSignal.initialize("d0204112-5603-42e3-96c8-1986d365f850", withLaunchOptions: launchOptions)
        
        return true
    }
    
    static var orientationLock = UIInterfaceOrientationMask.portrait {
        didSet {
            if #available(iOS 16.0, *) {
                UIApplication.shared.connectedScenes.forEach { scene in
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientationLock))
                    }
                }
                UIViewController.attemptRotationToDeviceOrientation()
            } else {
                if orientationLock == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orient")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orient")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
