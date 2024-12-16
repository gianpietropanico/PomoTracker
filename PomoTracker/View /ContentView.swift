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
                        
                        Button(action: { changeMode(to: .shortBreak) }) {
                            timerButtonContent(
                                text: "Short Break",
                                imageName: "cup.and.saucer.fill",
                                isActive: timerMode == .shortBreak,
                                textColor: currentStyle.textColor
                            )
                        }
                        
                        Button(action: { changeMode(to: .longBreak) }) {
                            timerButtonContent(
                                text: "Long Break",
                                imageName: "cup.and.saucer.fill",
                                isActive: timerMode == .longBreak,
                                textColor: currentStyle.textColor
                            )
                        }
                    }
            
                    TextField("", text: $title, prompt: Text("Enter title").foregroundStyle(Color.white.opacity(0.5))) // Nessun placeholder
                        .font(.custom("SFProDisplay-Regular", size: 40).italic())
                        .foregroundColor(.white) // Testo in bianco
                        .multilineTextAlignment(.center) // Centra il testo
                        .accentColor(.white) // Cursore in bianco
                        .padding()
                        .background(Color.clear) // Nessuno sfondo
                    
                    
                    // TimerView
                    TimerView(
                        counter: $counter,
                        countTo: .constant(currentStyle.countTo),
                        timerIsRunning: $timerIsRunning,
                        buttonColor: currentStyle.textColor,
                        textColor: .white
                    )
                    
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
                }
            }
        }
        .sheet(isPresented: $showOnboarding) {
            OnboardingView(isPresented: $showOnboarding) // Mostra l'Onboarding come sheet
        }
        .onAppear {
            // Salva che l'onboarding è stato visto
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
