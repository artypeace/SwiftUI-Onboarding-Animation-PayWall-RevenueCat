//
//  PayWallView.swift
//  SwiftUI-Onboarding-Animation-PayWall-RevenueCat
//
//  Created by Arty Peace on 6/1/23.
//

import SwiftUI
import RevenueCat

struct PayWallView: View {
        
    @Environment(\.presentationMode) var presentationMode
    @StateObject var subscriptionManager = IAPManager()
    @State private var isAdFree = UserDefaults.standard.bool(forKey: "isAdFree")

    // - State for displaying an overlay view
        @State private(set) var isPurchasing: Bool = false
        @State private var purchaseCompleted: Bool = false
        @State private var purchaseError: Bool = false

    //MARK: Body
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Spacer()
                VStack {
                    HStack {
                        // Ad-free mode
                        Text("Ad-free mode")
                            .font(.system(size: 34, weight: .heavy, design: .rounded))
                            .padding(.leading, 10)
                            .foregroundColor(Color(red: 153/255, green: 151/255, blue: 246/255))
                        Spacer()

                    } //:HStack
                        .padding(.top, 10)
                    
                    VStack(alignment: .leading) {
                        Text("I'm an independent developer creating products that I'd like to be useful to you")
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .multilineTextAlignment(.center)
                    } //:VStack
                    
                    .padding(.top, 10)
                    
                    VStack(alignment: .center) {
                        //TODO: - Add your image
                        Image("AddYourImage")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    
                    
                    ForEach(subscriptionManager.packages, id: \.identifier) { product in
                                        Button(action: {
                                            subscriptionManager.purchase(product: product) { success in
                                                if success {
                                                    purchaseCompleted = true
                                                    purchaseError = false
                                                    isAdFree = true
                                                    UserDefaults.standard.set(isAdFree, forKey: "isAdFree")
                                                } else {
                                                    purchaseCompleted = false
                                                    purchaseError = true
                                                    isAdFree = false
                                                    UserDefaults.standard.set(isAdFree, forKey: "isAdFree")
                                                }
                                            }
                                        }) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color(red: 153/255, green: 151/255, blue: 246/255))
                                        .frame(height: 55)
                                        .cornerRadius(10)
                                    IAPRow(product: product)
                                    
                                } //:ZStack
                            }
                        }
                    
                    .padding(.vertical)

                
                    HStack {
                        Button(action: {
                            //TODO: - Add your Privacy Policy
                            if let url = URL(string: "https://apple.com/") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("Privacy Policy")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        } .padding(.horizontal, 20)
                        Spacer()
                        Button(action: {
                            if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("Terms of Use")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        } .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 8)
                    
                    Button(action: {
                        Purchases.shared.restorePurchases(completion: nil)
                    }) {
                        //Restore purchases
                        Text("Restore Purchases")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 16)
                    
                    
                    
                    Spacer()
                } //:VStack
               
                .padding()
            } //:VStack
        }
        
        // Alerts for purchases
        .alert(isPresented: $purchaseCompleted) {
                  Alert(
                      title: Text("You're all set!"),
                      message: Text("Thank you for your purchase."),
                      dismissButton: .default(Text("OK"))
                  )
              }
              .alert(isPresented: $purchaseError) {
                  Alert(
                      title: Text("Your purchase has not been complete."),
                      message: Text("Please, try again."),
                      dismissButton: .default(Text("OK"))
                  )
              }
    }
}

struct IAPRow: View {

    var product: Package

    var body: some View {
        HStack {
            Text(product.storeProduct.localizedDescription)
            Spacer()
            Text(product.localizedPriceString)
        } //:HStack
        .font(.system(size: 14, weight: .bold, design: .rounded))
        .foregroundColor(.white)
        .padding(20)
    }
}

struct PayWallView_Previews: PreviewProvider {
    static var previews: some View {
        PayWallView()
            .environmentObject(IAPManager())
    }
}
