//
//  BlueView.swift
//  tabView
//
//  Created by Turma01-23 on 11/02/25.
//

import SwiftUI

struct BlueView: View {
    var body: some View {
        ZStack
        {
            Color.blue.edgesIgnoringSafeArea(.top)
            VStack
            {
                Image(systemName: "paintbrush.pointed").resizable().frame(width: 200, height: 200).foregroundColor(.blue).padding(40).background(.black).clipShape(Circle()).clipped()
            }
        }
    }
}

#Preview {
    BlueView()
}
