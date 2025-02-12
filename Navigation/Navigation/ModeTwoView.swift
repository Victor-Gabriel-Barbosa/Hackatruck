//
//  ModeTwoView.swift
//  Navigation
//
//  Created by Turma01-23 on 11/02/25.
//

import SwiftUI

struct ModeTwoView: View {
    
    @Binding var name: String
    @Binding var surname: String
    
    var body: some View 
    {
        NavigationStack
        {
            ZStack
            {
                Color("Roxozul").edgesIgnoringSafeArea(.all)
                VStack
                {
                    Text("Modo 2").foregroundStyle(.white).font(.largeTitle).padding(.top, 10).bold()
                    Spacer()
                    VStack
                    {
                        VStack
                        {
                            Text("\(name)").foregroundStyle(.white).font(.title3)
                            Text("Bem vindo, \(name)").bold().font(.title2).foregroundStyle(.white)
                        }.padding(.top,70)
                        NavigationLink(destination: ModeTwoTwoView(name: $name, surname: $surname))
                        {
                            Text("Acessar Tela").frame(width: 130, height: 30).foregroundColor(.white)
                        }.background(.blue).cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).padding(.top)
                        
                    }.frame(width: 350, height: 200).background(Color("RosaChoque")).cornerRadius(10).foregroundColor(.white)
                    Spacer()
                }
                
                VStack
                {
                    
                }
            }
        }
    }
}

#Preview {
    ModeTwoView(name: .constant(""), surname: .constant(""))
}
