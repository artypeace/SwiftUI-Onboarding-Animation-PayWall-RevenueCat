//
//  DataModel.swift
//  SwiftUI-Onboarding-Animation-PayWall-RevenueCat
//
//  Created by Arty Peace on 6/1/23.
//

import Foundation

enum DataModel {
    case step(StepView)
    case paywall(PayWallView)
}

struct StepView {
    var image: String
    var heading: String
    var text: String
}

extension DataModel {
    static var data: [DataModel] = [
         // each step of the array will add a new screen
        .step(StepView(image: "Onboarding1", heading: "Welcome to the App", text: "The following steps will explain ho to use the app most effectively.")),
        .step(StepView(image: "Onboarding2", heading: "Step 2", text: "Short description about Step 2")),
        .step(StepView(image: "OnBoarding3", heading: "Step 3", text: "Short description about Step 3")),
        .step(StepView(image: "Onboarding4", heading: "Step 4", text: "Short description about Step 4")),
        .paywall(PayWallView()),
        .step(StepView(image: "Onboarding5", heading: "Step 5", text: "Short description about Step 6")),
    ]
}
