//
//  ContentView.swift
//  Desafio01
//
//  Created by Turma01-23 on 06/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Rectangle().fill(.red).frame(width: 80, height: 80)
            
            Spacer()
            
            Rectangle().fill(.green).frame(width: 80, height: 80)
          
    }
        .padding()
        
        Spacer()
        
        HStack{
            Rectangle().fill(.blue).frame(width: 80, height: 80)
            
            Spacer()
            
            Rectangle().fill(.yellow).frame(width: 80, height: 80)
            
    
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
