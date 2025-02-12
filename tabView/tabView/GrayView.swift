//
//  GrayView.swift
//  tabView
//
//  Created by Turma01-23 on 11/02/25.
//

import SwiftUI

struct GrayView: View {
    var body: some View {
        ZStack
        {
            Color.gray.edgesIgnoringSafeArea(.top)
            VStack
            {
                Image(systemName: "paintpalette").resizable().frame(width: 200, height: 200).foregroundColor(.gray).padding(40).background(.black).clipShape(Circle()).clipped()
            }
        }
    }
}

#Preview {
    GrayView()
}
