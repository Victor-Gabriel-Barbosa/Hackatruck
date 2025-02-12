//
//  ContentView.swift
//  spotify
//
//  Created by Turma01-27 on 12/02/25.
//

import SwiftUI

struct Song: Identifiable {
    var id: Int
    var name:  String
    var artist: String
    var capa: String
}

struct ContentView: View {
    var arrayMusicas = [
        Song(id: 1, name:"Numb Encore", artist:"Linkin Park", capa:"lpCollisionCourse"),
        Song(id: 2, name:"Lost", artist:"Linkin Park", capa:"lpLOST"),
        Song(id: 3, name:"teste1", artist:"teste1", capa:"?"),
        Song(id: 4, name:"teste2", artist:"teste2", capa:"?"),
        Song(id: 5, name:"teste3", artist:"teste3", capa:"?"),
        Song(id: 6, name:"teste4", artist:"teste4", capa:"?")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Image("solo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    
                    VStack {
                        Text("SoloFM")
                            .font(.title)
                            .foregroundStyle(.white)
                        
                        HStack {
                            Image("solo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            Text("SoloSong")
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    
                    ScrollView {
                        VStack {
                            ForEach(arrayMusicas) { item in
                                NavigationLink(destination: showView(song: item)) {
                                    VStack {
                                        HStack {
                                            Image(item.capa)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                            
                                            VStack {
                                                Text(item.name)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .bold()
                                                Text(item.artist)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            }
                                            
                                            Spacer()
                                            
                                            Image(systemName: "ellipsis")
                                        }
                                    }
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            }
                        }
                        
                        
                        Spacer()
                        
                        VStack {
                            Text("Sugeridos")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    VStack {
                                        Image("numero1")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 200, height: 200)
                                        
                                        Text("1 - One")
                                            .foregroundStyle(.white)
                                    }
                                    
                                    VStack {
                                        Image("numero2")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 200, height: 200)
                                        
                                        Text("2 - Two")
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                            .frame(height: 200)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
