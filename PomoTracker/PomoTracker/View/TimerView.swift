import SwiftUI
import AVFoundation

struct TimerView: View {
    @Binding var counter: Int
    @Binding var countTo: Int
    @Binding var timerIsRunning: Bool

    var buttonColor: Color
    var textColor: Color
    
    @State private var showProgressView = false
    
    @State private var audioPlayer: AVAudioPlayer? // Gestore audio
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        VStack {
            ZStack {
                // Cerchio di sfondo
                Circle()
                    .fill(Color.clear)
                    .frame(width: 300, height: 300)
                    .overlay(Circle().stroke(buttonColor, lineWidth: 4))
                    .accessibilityHidden(true) // Nasconde elementi non necessari a VoiceOver

                // Cerchio progressivo che si riempie di bianco
                Circle()
                    .fill(Color.clear)
                    .frame(width: 300, height: 300)
                    .overlay(
                        Circle()
                            .trim(from: 0, to: progress())
                            .stroke(
                                style: StrokeStyle(
                                    lineWidth: 4,
                                    lineCap: .round,
                                    lineJoin: .round
                                )
                            )
                            .foregroundColor(.white)
                            .animation(.easeInOut(duration: 0.2), value: progress())
                    )
                    .accessibilityLabel("Timer progress, \(progressPercentage())% completed") // VoiceOver per il progresso

                // Testo centrale con il timer
                Text(counterToMinutes())
                    .font(.custom("SFProDisplay-Regular", size: 60).italic())
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .accessibilityLabel("Time remaining: \(counterToMinutes())") // VoiceOver per il timer
            }

            HStack(spacing: 10) {
                // Pulsante Progress View
                Button(action: {
                    showProgressView.toggle()
                }) {
                    Image(systemName: "chart.bar.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(buttonColor)
                        .foregroundColor(textColor)
                        .cornerRadius(20)
                }
                .accessibilityLabel("Show progress summary") // VoiceOver per il pulsante
                .fullScreenCover(isPresented: $showProgressView, content: {
                    ProgressView()
                })

                // Pulsante Play/Pause
                Button(action: {
                    timerIsRunning.toggle()
                }) {
                    Image(systemName: timerIsRunning ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                        .background(buttonColor)
                        .foregroundColor(textColor)
                        .cornerRadius(20)
                }
                .accessibilityLabel(timerIsRunning ? "Pause timer" : "Start timer") // VoiceOver per Play/Pause

                // Pulsante Reset
                Button(action: {
                    counter = 0
                    timerIsRunning = false
                }) {
                    Image(systemName: "forward.end.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(buttonColor)
                        .foregroundColor(textColor)
                        .cornerRadius(20)
                }
                .accessibilityLabel("Reset timer to zero") // VoiceOver per Reset
            }

        }
        .onReceive(timer) { _ in
            if timerIsRunning && counter < countTo {
                counter += 1
            } else if timerIsRunning && counter >= countTo {
                timerIsRunning = false
                playSound()
            }
        }
        .onAppear {
            setupSound()
        }
    }

    // Imposta il suono
    func setupSound() {
        guard let soundURL = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else {
            print("File audio non trovato.")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Errore nella configurazione del player audio: \(error.localizedDescription)")
        }
    }

    // Riproduce il suono
    func playSound() {
        audioPlayer?.play()
    }

    func completed() -> Bool {
        return progress() == 1
    }

    func progress() -> CGFloat {
        return CGFloat(counter) / CGFloat(countTo)
    }

    func progressPercentage() -> Int {
        return Int(progress() * 100)
    }

    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}


