//
//  OnboardingContentView.swift
//  SwiftUI-Onboarding-Animation-PayWall-RevenueCat
//
//  Created by Arty Peace on 6/1/23.
//

import SwiftUI
import ConfettiSwiftUI


struct OnboardingContentView: View {
    @State private var onboardingDone = false
    @Environment(\.presentationMode) var presentationMode

    
    @State private var showConfetti = false
    @State private var counter: Int = 0
    @State private var hasCompletedOnboarding = false

    
    var data = DataModel.data
    
    var body: some View {
        Group {
            if !onboardingDone {
                OnboardingViewPure(data: data, doneFunction: {
                    self.onboardingDone = true
                   
                    
                    self.presentationMode.wrappedValue.dismiss()
                })
            } else {
                Text("Hello world")
            }
        } .onAppear {
            showConfetti = true
            counter += 1
            
        }
        .confettiCannon(counter: $counter, repetitions: 5, repetitionInterval: 2.0)

    }
}

struct OnboardingContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContentView()
    }
}
