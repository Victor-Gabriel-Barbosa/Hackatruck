//
//  ContentView.swift
//  HackaZ
//
//  Created by Turma01-23 on 07/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    @State private var name = ""
    var body: some View {
        ZStack{
            Image("landscape").resizable().scaledToFill().opacity(0.2).edgesIgnoringSafeArea(.top).edgesIgnoringSafeArea(.bottom)
            VStack{
                VStack{
                    Text("Bem Vindo, \(name)").font(.largeTitle)
                }
                TextField("Coloque seu Nome", text: $name).multilineTextAlignment(.center)
                
                VStack{
                    Spacer()
                    Image("logo").resizable().scaledToFit().frame(width: 200, height: 100).shadow(radius: 20)
                    Image("truck").resizable().scaledToFit().frame(width: 300, height: 100).shadow(radius: 20)
                    Spacer()
                    Button(action: {
                        showingAlert = true
                    }, label: {
                        Text("Entrar").frame(maxWidth: .infinity).foregroundColor(.blue).font(.title2)
                    })
                    .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Alerta!").font(.largeTitle),
                                message: Text("Você irá iniciar o desafio da aula agora").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/),
                                dismissButton: .default(Text("Vamos lá!")) {
                                    }
                                  )
                            }
                }.padding(.top, 70)
            }
        }
    }
}

#Preview {
    ContentView()
}
