import SwiftUI

struct ProgressView: View {
    
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var colorScheme // Per rilevare la modalità chiaro/scuro
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                // Titolo
                Text("Your progress")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                    .foregroundColor(colorScheme == .dark ? .white : .black) // Colore dinamico
                    .accessibilityLabel("Your progress screen")
                
                ScrollView {
                    Image("chartss")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 350)
                        .padding()
                        .background(colorScheme == .dark ? Color.gray.opacity(0.1) : Color.white.opacity(0.2)) // Sfondo dinamico
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .accessibilityLabel("A bar chart showing your progress")
                    
                    VStack(spacing: 12) {
                        CardView(date: "Saturday, December 14, 2024",
                                 details: [
                                    ("History", "2h 30min", "3/ 4"),
                                    ("Math", "1h 30min", "4/ 4")
                                 ])
                        
                        CardView(date: "Monday, December 16, 2024", details: [("Swift", "3h 20min", "3.3/4")])
                        CardView(date: "Thursday, December 19, 2024", details: [ ("Physics", "2h 30min", "2.2/ 4")])
                    }
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 40, height: 40)
                            Image(systemName: "xmark")
                                .bold()
                                .foregroundStyle(colorScheme == .dark ? Color.black : Color.white) // Colore dinamico
                                .font(.subheadline)
                        }
                        .accessibilityLabel("Close Progress View")
                    }
                }
            }
            .background(colorScheme == .dark ? Color.black : Color.white) // Sfondo dinamico
        }
    }
}


struct CardView: View {
    let date: String
    let details: [(subject: String, duration: String, score: String)]
    
    @State private var isExpanded: Bool = false
    @Environment(\.colorScheme) var colorScheme // Per rilevare la modalità chiaro/scuro
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(date)
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(colorScheme == .dark ? .white : .black) // Colore dinamico
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.title)
                        .foregroundColor(.gray)
                        .accessibilityLabel(isExpanded ? "Collapse details" : "Expand details")
                }
                .padding()
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Session on \(date), tap to \(isExpanded ? "collapse" : "expand") details")
            
            if isExpanded && !details.isEmpty {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(details, id: \.subject) { detail in
                        HStack(spacing: 12) {
                            Circle()
                                .fill(colorScheme == .dark ? .white : .black) // Pallino dinamico
                                .frame(width: 12, height: 12)
                                .accessibilityHidden(true)
                            
                            Text(detail.subject)
                                .font(.custom("SFProDisplay-Regular", size: 20))
                                .bold()
                                .foregroundColor(colorScheme == .dark ? .white : .black) // Colore dinamico
                                .accessibilityLabel("Subject: \(detail.subject)")
                            
                            Spacer()
                            
                            Text(detail.duration)
                                .font(.custom("SFProDisplay-Regular", size: 18).italic())
                                .foregroundColor(colorScheme == .dark ? .white : .black) // Colore dinamico
                                .accessibilityLabel("Duration: \(detail.duration)")
                            
                            Text(detail.score)
                                .font(.title3)
                                .bold()
                                .foregroundColor(colorScheme == .dark ? .white : .black) // Colore dinamico
                                .accessibilityLabel("Score: \(detail.score)")
                            
                            Image(systemName: "star.fill")
                                .font(.title)
                                .foregroundColor(.yellow)
                                .accessibilityHidden(true)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white) // Sfondo dinamico
                .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
