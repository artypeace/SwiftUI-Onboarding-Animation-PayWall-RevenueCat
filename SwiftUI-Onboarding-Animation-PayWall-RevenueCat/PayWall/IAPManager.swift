//
//  IAPManager.swift
//  SwiftUI-Onboarding-Animation-PayWall-RevenueCat
//
//  Created by Arty Peace on 6/1/23.
//

import SwiftUI
import RevenueCat

class IAPManager: ObservableObject {
    static let shared = IAPManager()

    @Published var packages: [Package] = []
    @Published var inPaymentProgress = false

    init() {
        Purchases.shared.getOfferings { (offerings, _) in
            if let packages = offerings?.current?.availablePackages {
                self.packages = packages
            }
        }
    }
    
    func purchase(product: Package, completion: @escaping (Bool) -> Void) {
          guard !inPaymentProgress else { return }
          inPaymentProgress = true
          Purchases.shared.purchase(package: product) { (_, purchaserInfo, _, error) in
              self.inPaymentProgress = false
              completion(error == nil)
          }
      }

}


// TODO: - add your RevenueCat API Key and entitlementID
struct Constants {
    
    //TODO: - Add your API Key
    static let apiKey = "Your_API_Key"
    
  // Example entitlementID
    static let entitlementID = "Ad-free access"
}
