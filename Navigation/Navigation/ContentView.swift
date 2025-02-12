//
//  ContentView.swift
//  Navigation
//
//  Created by Turma01-23 on 11/02/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack
        {
                ZStack
                {
                    Color("Roxozul").edgesIgnoringSafeArea(.all)
                    VStack
                    {
                        Image("logo").resizable().scaledToFit()
                        Spacer()
                        NavigationLink(destination: ModeOneView(name: $name, surname: $surname))
                        {
                            Text("Modo 1").frame(width: 200, height: 100).foregroundColor(.white)
                        }.background(Color("RosaChoque")).cornerRadius(10)
                        
                        NavigationLink(destination: ModeTwoView(name: $name, surname: $surname))
                        {
                            Text("Modo 2").frame(width: 200, height: 100).foregroundColor(.white)
                        }.background(Color("RosaChoque")).cornerRadius(10)
                        
                        Button(action: 
                        {
                            showingSheet.toggle()
            
                        }, label: 
                        {
                            Text("Modo 3").frame(width: 200, height: 100).foregroundColor(.white)
                        })
                        .background(Color("RosaChoque")).cornerRadius(10)
                        .sheet(isPresented: $showingSheet)
                        {
                            ModeOneView(name: $name, surname: $surname)
                        }
                        Spacer()
                        
                    }
                }
        }.accentColor(.white)
        }
}

#Preview {
    ContentView()
}
