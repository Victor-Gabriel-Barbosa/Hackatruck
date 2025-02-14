//
//  ContentView.swift
//  harrypotter
//
//  Created by Turma01-27 on 14/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
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
                    }
                }
                .frame(height: 250)
                
                Text("Personagens de Harry Potter")
                    .font(.title)
                    .foregroundStyle(.orange)
                    .bold()
                
                ScrollView {
                    ForEach(viewModel.persona){ index in
                        HStack {
                            AsyncImage(url: URL(string: index.image!)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            
                            Text(index.name!)
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding()
                    }
                }
            }
        }
        .onAppear(){
            viewModel.fetch()
        }
    }
}

#Preview {
    ContentView()
}
