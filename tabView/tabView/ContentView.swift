//
//  ContentView.swift
//  tabView
//
//  Created by Turma01-23 on 11/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack
        {
            TabView 
            {
                PinkView()
                    .tabItem 
                {
                        Label("Rosa", systemImage: "paintbrush.fill")
                }
                BlueView()
                    .tabItem 
                {
                        Label("Azul", systemImage: "paintbrush.pointed.fill")
                }
                GrayView()
                    .tabItem 
                {
                        Label("Cinza", systemImage: "paintpalette.fill")
                }
                ListView()
                    .tabItem
                {
                        Label("Lista", systemImage: "list.bullet")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
