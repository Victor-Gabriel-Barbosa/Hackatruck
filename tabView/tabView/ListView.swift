//
//  ListView.swift
//  tabView
//
//  Created by Turma01-23 on 11/02/25.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        ZStack
        {
            NavigationView {
                NavigationStack {
                    List {
                        HStack
                        {
                            NavigationLink(destination: PinkView())
                            {
                                Text("Item")
                            }.accentColor(.orange)
                            Spacer()
                            Image(systemName: "paintbrush")
                        }
                        HStack
                        {
                            NavigationLink(destination: BlueView())
                            {
                                Text("Item")
                            }
                            Spacer()
                            Image(systemName: "paintbrush.pointed")
                        }
                        HStack
                        {
                            NavigationLink(destination: GrayView())
                            {
                                Text("Item")
                            }
                            Spacer()
                            Image(systemName: "paintpalette")
                        }
                        
                    }.navigationTitle("List")
                }
            }.accentColor(.black)

        }
    }
}

#Preview {
    ListView()
}
