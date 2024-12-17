import SwiftUI

struct MarkProgressView: View {
    
    let color = Color(UIColor(red: 238 / 255, green: 103 / 255, blue: 103 / 255, alpha: 1.0))
    @State private var topic: String = ""
    @State private var timeSpent: String = ""
    
    @State private var questions: [Question] = [
        Question(text: "How focused did you feel during this session?", answer: nil),
        Question(text: "Do you feel you have achieved the goals set for this session?", answer: nil),
        Question(text: "How well did you understand the material?", answer: nil),
        Question(text: "How satisfied are you with this session?", answer: nil),
        Question(text: "How motivated were you to study today?", answer: nil),
        Question(text: "How well do you feel you understood the material you studied?", answer: nil)
    ]
    
    @State private var showVoting: [Bool] = Array(repeating: false, count: 6) // Stato per mostrare i cerchi

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Details")) {
                    TextField("Topic name", text: $topic)
                        .accessibilityLabel("Enter the topic name")
                    
                    TextField("Time spent (1h 30min)", text: $timeSpent)
                        .accessibilityLabel("Enter the time spent in hours and minutes")
                }

                Section(header: Text("Questions")) {
                    ForEach(questions.indices, id: \.self) { index in
                        HStack(alignment: .center, spacing: 16) {
                            // Testo della domanda
                            Text(questions[index].text)
                                .font(.headline)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .layoutPriority(1)
                                .accessibilityLabel("Question \(index + 1): \(questions[index].text)")
                            
                            Spacer()
                            
                            if showVoting[index] {
                                // Cerchi per il voto
                                HStack(spacing: 8) {
                                    ForEach(1...4, id: \.self) { value in
                                        Circle()
                                            .stroke(Color.gray, lineWidth: 1)
                                            .background(
                                                Circle()
                                                    .fill(questions[index].answer ?? 0 >= value ? color : Color.clear)
                                            )
                                            .frame(width: 30, height: 30)
                                            .onTapGesture {
                                                if questions[index].answer == value {
                                                    questions[index].answer = nil
                                                } else {
                                                    questions[index].answer = value
                                                }
                                            }
                                            .accessibilityLabel("Rate \(value) out of 4 for question \(index + 1)")
                                            .accessibilityHint(questions[index].answer == value ? "Selected" : "Not selected")
                                    }
                                }
                            } else {
                                // Tasto "+" per mostrare i cerchi
                                Button(action: {
                                    withAnimation {
                                        showVoting[index] = true
                                    }
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(color)
                                        .accessibilityLabel("Show rating options for question \(index + 1)")
                                }
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }

            // Pulsante "Save Session"
            Button(action: saveSession) {
                Text("Save Session")
                    .font(.custom("SFProDisplay-Regular", size: 25).italic())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [color, color.opacity(0.8)]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal)
            .accessibilityLabel("Save the session")
        }
    }
    
    func calculateOverallScore() -> String {
        let totalQuestions = questions.count
        let maxScore = totalQuestions * 4

        let totalScore = questions.compactMap { $0.answer }.reduce(0, +)
        let normalizedScore = (Double(totalScore) / Double(maxScore)) * 4

        let roundedScore = (normalizedScore * 10).rounded() / 10

        if roundedScore.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", roundedScore)
        } else {
            return String(format: "%.1f", roundedScore)
        }
    }

    func saveSession() {
        print("Overall Score: \(calculateOverallScore())")
    }
}

struct MarkProgressView_Previews: PreviewProvider {
    static var previews: some View {
        MarkProgressView()
    }
}
