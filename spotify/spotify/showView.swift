//
//  showView.swift
//  spotify
//
//  Created by Turma01-27 on 12/02/25.
//

import SwiftUI

struct showView: View {
    var song: Song
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    Image(song.capa)
                        .resizable()
                        .frame(width: 200, height: 200)
                    
                    Text(song.name)
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                        .bold()
                    
                    Text(song.artist)
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Image(systemName: "shuffle")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Spacer()
                    Image(systemName: "backward.end.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Spacer()
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Spacer()
                    Image(systemName: "forward.end.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Spacer()
                    Image(systemName: "repeat")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Spacer()
                }
                .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

#Preview {
    showView(song: Song(id: 1, name: "Numb Encore", artist: "Linkin Park", capa: "lpCollisionCourse"))
}
