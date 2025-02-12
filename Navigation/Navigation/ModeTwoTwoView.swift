//
//  ModeTwoView.swift
//  Navigation
//
//  Created by Turma01-23 on 11/02/25.
//

import SwiftUI

struct ModeTwoTwoView: View {
    
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
                        NavigationLink(destination: ModeTwoView(name: $name, surname: $surname))
                        {
                            Text("Volte \n\(name)!").frame(width: 130, height: 50).foregroundColor(.white).bold().font(.title3)
                        }.background(Color("RosaChoque")).cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).padding(.top)
                        
                    }
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
