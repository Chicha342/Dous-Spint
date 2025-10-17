//
//  StoreManager.swift
//  DousSpint
//
//  Created by Никита on 06.10.2025.
//

import Foundation
import StoreKit

@MainActor
final class StoreManager: NSObject, ObservableObject  {
    static let shared = StoreManager()
    
    @Published var purchasedDarkTheme = false
    @Published var purchasedExport = false
    @Published var products: [Product] = []
    
    private let darkThemeId = "dark_Theme_unlock"
    private let exportDataId = "export_data_unlock"
    
    override init() {
        super.init()
        Task {
            await fetchProducts()
            await updatePurchasedStatus()
        }
    }
    
    // MARK: - Fetch Products
    func fetchProducts() async {
        do {
            let storeProducts = try await Product.products(for: [darkThemeId, exportDataId])
            self.products = storeProducts
        } catch {
            print("Error loading products: \(error)")
        }
    }
    
    @Published var restoreSuccess = false
    @Published var restoreError: String? = nil
    
    // MARK: - Restore Purchases
    func restorePurchases() async {
        do {
            purchasedDarkTheme = false
            purchasedExport = false
            
            await updatePurchasedStatus()
            
            if purchasedDarkTheme || purchasedExport {
                restoreSuccess = true
                restoreError = nil
                print("Purchases restored successfully")
            } else {
                restoreError = "No previous purchases found"
                restoreSuccess = false
            }
        }
    }
    
    // MARK: - Purchase Product
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verification):
                if case .verified(let transaction) = verification {
                    // Завершение транзакции обязательно для SK2
                    await transaction.finish()
                    await updatePurchasedStatus()
                }
            case .userCancelled:
                print("User cancelled")
            case .pending:
                print("Purchase pending...")
            @unknown default:
                break
            }
            
        } catch {
            print("Error purchasing product: \(error)")
        }
    }
    
    // MARK: - Update Purchased Status
    func updatePurchasedStatus() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else { continue }
            switch transaction.productID {
            case darkThemeId:
                purchasedDarkTheme = true
            case exportDataId:
                purchasedExport = true
            default:
                break
            }
        }
    }
}
