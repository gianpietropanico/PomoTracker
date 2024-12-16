//
//  TimerStyles.swift
//  TimerTest
//
//  Created by Gianpietro Panico on 12/12/24.
//

import SwiftUI

// Enum per le modalità del timer
enum TimerMode {
    case focus, shortBreak, longBreak
}

// Struttura per lo stile del timer
struct TimerStyle {
    var background: Color
    var buttonColor: Color
    var textColor: Color
    var countTo: Int
}

// Funzione per ottenere lo stile in base alla modalità
func getStyle(for mode: TimerMode) -> TimerStyle {
    switch mode {
    case .focus:
        return TimerStyle(
            background: Color(UIColor(red: 186 / 255, green: 73 / 255, blue: 73 / 255, alpha: 1.0)),
            buttonColor: .white,
            textColor: Color(UIColor(red: 238 / 255, green: 103 / 255, blue: 103 / 255, alpha: 1.0)),
            countTo: 1500
        )
    case .shortBreak:
        return TimerStyle(
            background: Color(UIColor(red: 56 / 255, green: 133 / 255, blue: 138 / 255, alpha: 1.0)),
            buttonColor: .white,
            textColor: Color(UIColor(red: 67 / 255, green: 159 / 255, blue: 165 / 255, alpha: 1.0)),
            countTo: 300
        )
    case .longBreak:
        return TimerStyle(
            background: Color(UIColor(red: 57 / 255, green: 112 / 255, blue: 151 / 255, alpha: 1.0)),
            buttonColor: .white,
            textColor: Color(UIColor(red: 67 / 255, green: 135 / 255, blue: 182 / 255, alpha: 1.0)),
            countTo: 900
        )
    }
}
