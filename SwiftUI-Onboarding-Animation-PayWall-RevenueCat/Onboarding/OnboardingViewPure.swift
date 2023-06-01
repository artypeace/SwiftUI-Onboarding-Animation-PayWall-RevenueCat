//
//  OnboardingViewPure.swift
//  SwiftUI-Onboarding-Animation-PayWall-RevenueCat
//
//  Created by Arty Peace on 6/1/23.
//

import SwiftUI
import ConfettiSwiftUI
import StoreKit

struct OnboardingViewPure: View {
    var data: [DataModel]
    var doneFunction: () -> ()

    @State var slideGesture: CGSize = CGSize.zero
    @State var curSlideIndex = 0
    var distance: CGFloat = UIScreen.main.bounds.size.width


    func nextButton() {
        if self.curSlideIndex == self.data.count - 1 {
            
            requestAppReview()
            doneFunction()
            return
        }

        if self.curSlideIndex < self.data.count - 1 {
            withAnimation {
                self.curSlideIndex += 1
            }
        }
    }

    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(.all)

            ZStack(alignment: .center) {
                ForEach(0..<data.count) { i in
                    OnboardingStepView(data: self.data[i])
                        .offset(x: CGFloat(i) * self.distance)
                        .offset(x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance)
                        .animation(.spring())
                        .gesture(DragGesture().onChanged{ value in
                            self.slideGesture = value.translation
                        }
                        .onEnded{ value in
                            if self.slideGesture.width < -50 {
                                if self.curSlideIndex < self.data.count - 1 {
                                    withAnimation {
                                        self.curSlideIndex += 1
                                    }
                                }
                            }
                            if self.slideGesture.width > 50 {
                                if self.curSlideIndex > 0 {
                                    withAnimation {
                                        self.curSlideIndex -= 1
                                    }
                                }
                            }
                            self.slideGesture = .zero
                        })
                }
            }


            VStack {
                Spacer()
                HStack {
                    self.progressView()
                    Spacer()
                    Button(action: nextButton) {
                        self.arrowView()
                    }
                }
            }
            .padding(20)
           
        }
    }

    func arrowView() -> some View {
        Group {
            if self.curSlideIndex == self.data.count - 1 {
                HStack {
                    Button(action: doneFunction) {
                        Text("Exit")
                            .font(.system(size: 27, weight: .medium, design: .rounded))
                            .foregroundColor(Color(.systemBackground))
                        

                    }
                }
                .frame(width: 120, height: 50)
                .background(Color(red: 95/255, green: 186/255, blue: 142/255))

                .cornerRadius(25)
                
             
            } else {
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .foregroundColor(Color(red: 95/255, green: 186/255, blue: 142/255))
                    .scaledToFit()
                    .frame(width: 50)
            }
        }
    }
    
    func requestAppReview() {
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }

    func progressView() -> some View {
        HStack {
            ForEach(0..<data.count) { i in
                Circle()
                    .scaledToFit()
                    .frame(width: 10)
                    .foregroundColor(self.curSlideIndex >= i ? Color(red: 95/255, green: 186/255, blue: 142/255) : Color(.systemGray))
            }
        }
    }

}

struct OnboardingViewPure_Previews: PreviewProvider {
    static let sample = DataModel.data
    static var previews: some View {
        OnboardingViewPure(data: sample, doneFunction: { print("done") })
    }
}


