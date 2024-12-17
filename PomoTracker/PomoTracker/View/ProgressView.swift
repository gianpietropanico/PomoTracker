import SwiftUI

struct ProgressView: View {
    
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                // Titolo
                Text("Your progress")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                
                Image("charts")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 350) // Dimensione più grande
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                ScrollView{
                    // Card Section
                    VStack(spacing: 12) {
                        CardView(date: "Monday, november 11, 2024",
                                 details: [
                                    ("Story", "2h 30 min", "3.7 / 4"),
                                    ("Geografy", "1h 30 min", "4 / 4")
                                 ])
                        
                        CardView(date: "Friday, november 29, 2024", details: [])
                        CardView(date: "Sunday, december 15, 2024", details: [])
                    }
                }
                Spacer()
            }
            .toolbar {
                                      ToolbarItem(placement: .topBarLeading) {
                                          Button {
                                              mode.wrappedValue.dismiss()
                                          } label: {
                                              ZStack{
                                                  Circle()
                                                      .fill(Color.gray.opacity(0.3))
                                                      .frame(width: 40, height: 40)
                                                  Image(systemName: "xmark")
                                                      .bold()
                                                      .foregroundStyle(.white)
                                                      .font(.subheadline)
                        }
                    }
                }
            }
        }
    }
}

struct CardView: View {
    let date: String
    let details: [(subject: String, duration: String, score: String)]
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(date)
                        .font(.system(size: 23)) // Testo della data ancora più grande
                        .bold()
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            if isExpanded && !details.isEmpty {
                VStack(alignment: .leading, spacing: 20) { // Più spazio tra i dettagli
                    ForEach(details, id: \.subject) { detail in
                        HStack(spacing: 12) { // Più spazio orizzontale
                            // Pallino fisso
                            Circle()
                                .fill(Color.black)
                                .frame(width: 12, height: 12) // Pallino più grande
                            
                            // Nome della materia
                            Text(detail.subject)
                                .font(.title3) // Testo materia più grande
                                .bold()
                            
                            Spacer()
                            
                            // Durata
                            Text(detail.duration)
                                .font(.title3) // Testo durata più grande
                            
                            // Punteggio
                            Text(detail.score)
                                .font(.title3) // Testo punteggio più grande
                                .bold()
                            
                            // Emoticon stella
                            Image(systemName: "star.fill")
                                .font(.title) // Stella più grande
                                .foregroundColor(.yellow)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
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
