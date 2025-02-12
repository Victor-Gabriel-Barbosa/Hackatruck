//
//  ContentView.swift
//  Desafio02
//
//  Created by Turma01-23 on 06/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image("hackaImagem").frame(width: 130, height: 130).clipShape(Circle()).padding(30)
                Spacer()
            VStack
            {
                Text("Hackatruck").foregroundStyle(.red).font(.title3)
                Text("77 Universidades").foregroundStyle(.blue).font(.title3)
                Text("5 regiões do Brasil").foregroundStyle(.yellow).font(.title3)
            }
            .padding()
        }
        
    }
}

#Preview {
    ContentView()
}
