//
//  PinkView.swift
//  tabView
//
//  Created by Turma01-23 on 11/02/25.
//

import SwiftUI

struct PinkView: View {
    var body: some View {
        ZStack
        {
            Color.pink.edgesIgnoringSafeArea(.top)
            VStack
            {
                Image(systemName: "paintbrush").resizable().frame(width: 200, height: 200).foregroundColor(.pink).padding(40).background(.black).clipShape(Circle()).clipped()
            }
        }
    }
}

#Preview {
    PinkView()
}
