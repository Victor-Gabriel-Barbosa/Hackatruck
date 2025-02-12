//
//  ModeOneView.swift
//  Navigation
//
//  Created by Turma01-23 on 11/02/25.
//

import SwiftUI

struct ModeOneView: View {
    
    @Binding var name: String
    @Binding var surname: String
    
    var body: some View {
        ZStack
        {
            Color("Roxozul").edgesIgnoringSafeArea(.all)
            VStack
            {
                Text("Modo 1").foregroundStyle(.white).font(.largeTitle).padding(.top, 10).bold()
                Spacer()
                VStack
                {
                    HStack
                    {
                        Text("Nome: ").foregroundStyle(.white)
                        
                        TextField("", text: $name, prompt: Text("Digite o seu nome...").foregroundColor(.white)).multilineTextAlignment(.center).frame(width: 200, height: 30)
                    }
                    HStack
                    {
                        Text("Sobrenome: ").foregroundStyle(.white)
                        
                        TextField("", text: $surname, prompt: Text("Digite o seu sobrenome...").foregroundColor(.white)).multilineTextAlignment(.center).frame(width: 200, height: 30)
                    }
                }.frame(width: 350, height: 150).background(Color("RosaChoque")).cornerRadius(10).foregroundColor(.white)
                Spacer()
            }
        }
    }
}

#Preview {
    ModeOneView(name: .constant(""), surname: .constant(""))
}

