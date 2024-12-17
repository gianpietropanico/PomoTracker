//
//  d.swift
//  TimerTest
//
//  Created by Gianpietro Panico on 14/12/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var isPresented: Bool
    let color = Color(UIColor(red: 238 / 255, green: 103 / 255, blue: 103 / 255, alpha: 1.0))
    
    var body: some View {

        VStack(spacing: 40) {
            Spacer()
            
            Text("Welcome to PomoTrack")
                .font(.system(size: 34))
                .fontWeight(.bold)
                .lineLimit(1)
                .accessibilityLabel("Welcome to PomoTrack")
            
            // Schermata 1
            OnboardingPageView(
                imageName: "brain",
                title: "Set your timer",
                description: "Organize your study and break sessions with a timer."
            )

            // Schermata 2
            OnboardingPageView(
                imageName: "pencil.and.scribble",
                title: "Mark your progress",
                description: "After a day of study, record your progress."
            )

            // Schermata 3
            OnboardingPageView(
                imageName: "chart.bar.xaxis",
                title: "Analyze your results",
                description: "View your session statistics to improve your productivity."
            )

            Spacer()

            Button(action: {
                isPresented = false
            }) {
                Text("Let's focus !")
                    .font(.custom("SFProDisplay-Regular", size: 25).italic())
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(color)
                    .cornerRadius(20)
                    .padding()
            }
            .accessibilityLabel("Let's focus! Start using PomoTrack")
            .accessibilityHint("Dismiss the onboarding screen and go to the main app.")
        }
        .padding()
    }
}

struct OnboardingPageView: View {
    
    let imageName: String
    let title: String
    let description: String
    let color = Color(UIColor(red: 238 / 255, green: 103 / 255, blue: 103 / 255, alpha: 1.0))
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .foregroundColor(color)
                .accessibilityHidden(true) // L'immagine è decorativa, quindi nascosta per VoiceOver

            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .accessibilityLabel(title)

                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .accessibilityLabel(description)
            }
        }
        .padding()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isPresented: .constant(true))
    }
}
