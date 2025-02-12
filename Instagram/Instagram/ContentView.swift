//
//  ContentView.swift
//  Instagram
//
//  Created by Turma01-23 on 07/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Divider()
        HStack
        {
            Text("@mariahmoraes27")
            Spacer()
            Image(systemName: "arrow.clockwise").font(.title2).foregroundColor(.gray)
            Image(systemName: "slider.horizontal.3").font(.title2).foregroundColor(.gray)
        }.padding(.horizontal, 5)
        .padding(.vertical, 2)
        
        Divider()
        HStack {
            ZStack{
                Image("perfil").resizable().scaledToFit().clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).frame(width: 100, height: 100).padding()
                Image(systemName: "plus.circle.fill").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).font(.title2).offset(x: 35, y: 40)
            }
            VStack{
                HStack{
                    VStack{
                        VStack{
                            Text("8").bold()
                            Text("Posts")}
                    }
                    VStack{
                        VStack{
                            Text("12K").bold()
                            Text("Seguidores")
                        }
                    }
                    VStack{
                        VStack{
                            Text("2K").bold()
                            Text("Seguindo")
                        }
                    }
                }
                Button(action: {
                    print("Pressionado")
                }, label: {
                    Text("Editar Perfil").frame(maxWidth: .infinity).foregroundColor(.black)
                })
                .buttonStyle(.bordered)
                .tint(.gray)

                
            }.padding()
        }
        VStack(alignment: .leading)
        {
            Text("Mariah Moaraes").font(.headline)
            Text("Eu amo narcisos, margaridas, rosas e túlipas")
        }
        .padding()
        Divider()
        HStack
        {
            Image(systemName: "squareshape.split.3x3").foregroundColor(.gray)
                .font(.largeTitle).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            Image(systemName: "square.inset.filled").foregroundColor(.gray)
                .font(.largeTitle).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            Image(systemName: "person.crop.circle").foregroundColor(.gray)
                .font(.largeTitle).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }.padding(.horizontal, 5)
        .padding(.vertical, 5)
        Divider()
        Spacer()
        VStack
        {
            HStack
            {
                VStack
                {
                    Rectangle().fill(.gray).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
                VStack
                {
                    Rectangle().fill(.gray).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
                VStack
                {
                    Rectangle().fill(.gray).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
            }
            HStack
            {
                VStack
                {
                    Rectangle().fill(.gray).frame(maxWidth: .infinity)
                }
                
                VStack
                {
                    Rectangle().fill(.gray).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
                
                VStack
                {
                    Rectangle().fill(.gray).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
            }
            HStack
            {
                VStack
                {
                    Rectangle().fill(.gray).frame(maxWidth: .infinity)
                }
                
                VStack
                {
                    Rectangle().fill(.gray).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
                
                VStack
                {
                    Rectangle().fill(.gray).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
            }
        }

    }
}

#Preview {
    ContentView()
}
