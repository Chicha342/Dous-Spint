//
//  StoreManager.swift
//  DousSpint
//
//  Created by Никита on 06.10.2025.
//

import Foundation
import StoreKit

final class StoreManager: ObservableObject {
    @Published var purchasedDarkTheme = false
    @Published var purchasedExport = false
    
    @Published var products: [Product] = []
    
    private let darkThemeId = "dark_Theme_unlock"
    private let exportDataId = "export_data_unlock"
    
    init() {
        Task{
            await fetchProducts()
            await updatePurchasedStatus()
        }
    }

    func fetchProducts() async{
        do{
            let storeProducts = try await Product.products(for: [darkThemeId, exportDataId])
            DispatchQueue.main.async{
                self.products = storeProducts
            }
        }catch{
            print("Error loading products: \(error)")
        }
    }
    
    func purchase(_ product: Product) async {
        do{
            let result = try await product.purchase()
            switch result {
            case .success(let verefication):
                if case .verified(let transaction) = verefication {
                    await transaction.finish()
                    await updatePurchasedStatus()
                }
            case .userCancelled:
                print("User cancelled")
            case .pending:
                print("Pending...")
            }
        }catch{
            print("Error purchasing product: \(error)")
        }
    }
    
    func updatePurchasedStatus() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else { continue }
            DispatchQueue.main.async {
                switch transaction.productID {
                case self.darkThemeId:
                    self.purchasedDarkTheme = true
                case self.exportDataId:
                    self.purchasedExport = true
                default:
                    break
                }
            }
        }
    }
    
    
}

