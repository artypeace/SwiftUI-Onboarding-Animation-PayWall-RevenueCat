//
//  ContentView.swift
//  SwiftUI-Onboarding-Animation-PayWall-RevenueCat
//
//  Created by Arty Peace on 6/1/23.
//

import SwiftUI
import ConfettiSwiftUI


struct ContentView: View {
    var body: some View {
            NavigationView {
                VStack {
                    
                    NavigationLink(destination: OnboardingContentView()) {
                        Text("Open Onboarding")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

