//
//  ContentView.swift
//  harrypotter
//
//  Created by Turma01-27 on 14/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var showingSheet = false
    @State private var selectedCharacter: HaPo?
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            Image("biblioteca")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 5)
            
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .padding()
                    .shadow(radius: 10)
                
                Text("Personagens de Harry Potter")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                    .shadow(radius: 5)
                
                ScrollView {
                    ForEach(viewModel.persona) { index in
                        HStack {
                            AsyncImage(url: URL(string: index.image!)) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            .padding(.trailing, 10)
                            
                            Text(index.name!)
                                .font(.headline)
                                .foregroundColor(.white)
                                .lineLimit(1)
                        }
                        .padding()
                        .frame(height: 70)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
                        .onTapGesture {
                            selectedCharacter = index
                            showingSheet = true
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.3)))
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $showingSheet) {
            if let character = selectedCharacter {
                ZStack {
                    Image(character.house ?? "placeholder")
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 3.0)
                    
                    VStack(spacing: 20) {
                        Spacer()
                        
                        AsyncImage(url: URL(string: character.image ?? "")) { image in
                            image.resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 200, height: 200)
                        .shadow(radius: 10)
                        
                        Text(character.house ?? "Casa Desconhecida")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
                        
                        Text(character.name ?? "Desconhecido")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2)))
                        
                        if let alternateNames = character.alternate_names, !alternateNames.isEmpty {
                            Text("Nomes Alternativos: \(alternateNames.joined(separator: ", "))")
                                .foregroundColor(.white)
                                .italic()
                        }
                        
                        CharacterDetailView(title: "Espécie", value: character.species ?? "Desconhecido")
                        CharacterDetailView(title: "Gênero", value: character.gender ?? "Desconhecido")
                        CharacterDetailView(title: "Data de Nascimento", value: character.dateOfBirth ?? "Desconhecido")
                        CharacterDetailView(title: "Mago", value: character.wizard == true ? "sim" : "não")
                        CharacterDetailView(title: "Linhagem", value: character.ancestry ?? "Desconhecido")
                        CharacterDetailView(title: "Cor de Olho", value: character.eyeColour ?? "Desconhecido")
                        CharacterDetailView(title: "Cor de Cabelo", value: character.hairColour ?? "Desconhecido")
                        CharacterDetailView(title: "Patronos", value: character.patronus ?? "Desconhecido")
                        CharacterDetailView(title: "Ator", value: character.actor ?? "Desconhecido")
                        CharacterDetailView(title: "Varinha", value: "\(character.wand.wood ?? "Desconhecida") com \(character.wand.core ?? "Núcleo Desconhecido")")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.6)))
                }
            }
        }
        .onAppear() {
            viewModel.fetch()
        }
    }
}

struct CharacterDetailView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text("\(title):")
                .foregroundColor(.white)
                .bold()
            Text(value)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ContentView()
}
