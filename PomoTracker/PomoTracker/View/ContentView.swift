import SwiftUI

struct ContentView: View {
    
    @State private var timerMode: TimerMode = .focus
    @State private var counter: Int = 0
    @State private var timerIsRunning: Bool = false
    @State private var showOnboarding: Bool = !UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    @State private var title: String = ""

    var body: some View {
        let currentStyle = getStyle(for: timerMode)
        
        NavigationStack {
            ZStack {
                currentStyle.background
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    HStack {
                        Button(action: { changeMode(to: .focus) }) {
                            timerButtonContent(
                                text: "Focus",
                                imageName: "brain",
                                isActive: timerMode == .focus,
                                textColor: currentStyle.textColor
                            )
                        }
                        .accessibilityLabel("Start Focus Mode") // VoiceOver per il pulsante
                        
                        Button(action: { changeMode(to: .shortBreak) }) {
                            timerButtonContent(
                                text: "Short Break",
                                imageName: "cup.and.saucer.fill",
                                isActive: timerMode == .shortBreak,
                                textColor: currentStyle.textColor
                            )
                        }
                        .accessibilityLabel("Start Short Break") // VoiceOver per il pulsante
                        
                        Button(action: { changeMode(to: .longBreak) }) {
                            timerButtonContent(
                                text: "Long Break",
                                imageName: "fork.knife",
                                isActive: timerMode == .longBreak,
                                textColor: currentStyle.textColor
                            )
                        }
                        .accessibilityLabel("Start Long Break") // VoiceOver per il pulsante
                    }
                    
                    // TextField con VoiceOver
                    TextField("", text: $title, prompt: Text("Enter title").foregroundStyle(Color.white.opacity(0.5)))
                        .font(.custom("SFProDisplay-Regular", size: 40).italic())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .accentColor(.white)
                        .padding()
                        .background(Color.clear)
                        .opacity(timerMode == .focus ? 1 : 0)
                        .frame(height: 50)
                        .accessibilityLabel("Enter a title for your session") // VoiceOver per il TextField
                    
                    // TimerView
                    TimerView(
                        counter: $counter,
                        countTo: .constant(currentStyle.countTo),
                        timerIsRunning: $timerIsRunning,
                        buttonColor: currentStyle.textColor,
                        textColor: .white
                    )
                    .accessibilityLabel("Timer, \(counterToMinutes()) remaining") // VoiceOver per il Timer
                    
                    NavigationLink {
                        MarkProgressView()
                    } label: {
                        Text("Mark your progress")
                            .frame(width: 270, height: 60)
                            .font(.custom("SFProDisplay-Regular", size: 26).italic())
                            .foregroundColor(.white)
                            .background(currentStyle.textColor)
                            .cornerRadius(10)
                    }
                    .accessibilityLabel("Navigate to Progress Marking Screen") // VoiceOver per il NavigationLink
                }
            }
        }
        .sheet(isPresented: $showOnboarding) {
            OnboardingView(isPresented: $showOnboarding)
        }
        .onAppear {
            if showOnboarding {
                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            }
        }
    }
    
    func changeMode(to mode: TimerMode) {
        resetTimerIfRunning()
        timerMode = mode
    }
    
    func resetTimerIfRunning() {
        if timerIsRunning {
            timerIsRunning = false
            counter = 0
        }
    }
    
    func timerButtonContent(text: String, imageName: String, isActive: Bool, textColor: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(isActive ? textColor : .white)
            
            Text(text)
                .font(.custom("SFProDisplay-Regular", size: 18).italic())
                .foregroundColor(isActive ? textColor : .white)
                .minimumScaleFactor(0.5)
        }
        .padding()
        .frame(width: 120, height: 80)
        .background(isActive ? .white : textColor)
        .cornerRadius(10)
    }
    
    func counterToMinutes() -> String {
        let minutes = counter / 60
        let seconds = counter % 60
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
