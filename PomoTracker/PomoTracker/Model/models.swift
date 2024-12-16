//
//  models.swift
//  TimerTest
//
//  Created by Gianpietro Panico on 11/12/24.
//

import Foundation

// Modello per una domanda
struct Question: Identifiable, Codable {
    var id: UUID = UUID()       // ID univoco, inizializzato come mutabile
    let text: String            // Testo della domanda
    var answer: Int?            // Risposta dell'utente (opzionale, da 0 a 4)
}

// Modello per una sessione di studio

struct StudySession: Identifiable, Codable {
    var id: UUID = UUID()       // ID univoco, inizializzato come mutabile
    let date: Date              // Data della sessione
    var topic: String           // Argomento studiato
    var timeSpent: Int          // Tempo trascorso in minuti
    var questions: [Question]   // Lista delle domande
    
    
    // Calcolo del punteggio medio
    var averageScore: Double {
        let scores = questions.compactMap { $0.answer }
        return scores.isEmpty ? 0 : Double(scores.reduce(0, +)) / Double(scores.count)
    }
}

/*
let session = StudySession(date: <#T##Date#>, topic: <#T##String#>, timeSpent: <#T##Int#>, questions: <#T##[Question]#>)
modelContext.insert(session)
*/
