//
//  SwiftUI_Onboarding_Animation_PayWall_RevenueCatApp.swift
//  SwiftUI-Onboarding-Animation-PayWall-RevenueCat
//
//  Created by Arty Peace on 6/1/23.
//

import SwiftUI
import RevenueCat

@main
struct SwiftUI_Onboarding_Animation_PayWall_RevenueCatApp: App {
    
    
    init() {
           Purchases.logLevel = .debug
           Purchases.configure(with: Configuration.Builder(withAPIKey: Constants.apiKey).with(usesStoreKit2IfAvailable: true).build())
           Purchases.shared.delegate = PurchasesDelegateHandler.shared
       }
    
    
    //MARK: - If your app based on Storyboard, add it to AppDelegate
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        Purchases.logLevel = .debug
//        Purchases.configure(with: Configuration.Builder(withAPIKey: Constants.apiKey).with(usesStoreKit2IfAvailable: true).build())
//
//        Purchases.shared.delegate = self
//
//        return true
//    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//MARK: - If your app based on Storyboard, add extension to AppDelegate instead of PurchasesDelegateHandler file from PayWall folder

//extension AppDelegate: PurchasesDelegate {
//    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
//        print("Modified")
//    }
//}
