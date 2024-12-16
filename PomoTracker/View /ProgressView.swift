//
//  ProgressView.swift
//  TimerTest
//
//  Created by Gianpietro Panico on 11/12/24.
//
import SwiftUI

struct ProgressView: View {
    
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        
        NavigationStack{
            VStack {
                Text("cisdaij")
               
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

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
