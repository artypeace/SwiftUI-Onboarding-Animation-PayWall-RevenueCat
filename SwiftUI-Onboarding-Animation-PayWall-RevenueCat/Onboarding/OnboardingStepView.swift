//
//  OnboardingStepView.swift
//  SwiftUI-Onboarding-Animation-PayWall-RevenueCat
//
//  Created by Arty Peace on 6/1/23.
//

import SwiftUI
import ConfettiSwiftUI


struct OnboardingStepView: View {
    var data: DataModel
    
    @State private var showConfetti = false
    
    @State private var counter: Int = 0

    
    var body: some View {
        switch data {
        case .step(let step):
            
            VStack {
                Image(step.image)
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 10)
                        .padding(.horizontal, 10)

                Text(step.heading)
                    .font(.system(size: 25, design: .rounded))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text(step.text)
                    .font(.system(size: 17, design: .rounded))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60)
            }
            .padding()
            .contentShape(Rectangle())
                
        case .paywall(let paywall):
            paywall
        }
    }
}


struct OnboardingStepView_Previews: PreviewProvider {
    static var data = DataModel.data[0]
    static var previews: some View {
        OnboardingStepView(data: data)
    }
}
