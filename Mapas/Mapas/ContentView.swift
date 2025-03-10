//
//  ContentView.swift
//  Mapas
//
//  Created by Turma01-27 on 13/02/25.
//

import SwiftUI
import MapKit

struct Location: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let flag: String
    let description: String
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id &&
           lhs.name == rhs.name &&
           lhs.coordinate.latitude == rhs.coordinate.latitude &&
           lhs.coordinate.longitude == rhs.coordinate.longitude &&
           lhs.flag == rhs.flag &&
           lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(coordinate.latitude)
        hasher.combine(coordinate.longitude)
        hasher.combine(flag)
        hasher.combine(description)
    }
}

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -14.2350, longitude: -51.9253),
        span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
    )
    
    let locations = [
        Location(name: "Brasília", coordinate: CLLocationCoordinate2D(latitude: -15.8267, longitude: -47.9218), flag: "🇧🇷", description: "Capital do Brasil"),
        Location(name: "Nova York", coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), flag: "🇺🇸", description: "Cidade famosa nos EUA"),
        Location(name: "Tóquio", coordinate: CLLocationCoordinate2D(latitude: 35.682839, longitude: 139.759455), flag: "🇯🇵", description: "Capital do Japão")
    ]
    
    @State private var selectedLocation: Location?
    @State private var showingSheet = false
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Text(location.flag)
                            .font(.largeTitle)
                        Text(location.name)
                            .font(.caption)
                            .padding(5)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(5)
                    }
                }
            }
            .ignoresSafeArea()
            
            VStack {
                Picker("Escolha um local", selection: $selectedLocation) {
                    Text("Selecione um local").tag(Location?.none)
                    ForEach(locations) { location in
                        Text("\(location.flag) \(location.name)").tag(location as Location?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedLocation) { newLocation in
                    if let location = newLocation {
                        region = MKCoordinateRegion(
                            center: location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
                        )
                    }
                }
                .padding()
                .background(Color.yellow.opacity(0.8))
                .cornerRadius(10)
                .padding()
                
                Spacer()
                
                if let location = selectedLocation {
                    Button(location.name) {
                        showingSheet = true
                    }
                    .padding()
                    .background(.yellow)
                    .cornerRadius(6.0)
                    .sheet(isPresented: $showingSheet) {
                        ZStack {
                            Color.yellow.opacity(0.4).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            VStack {
                                Image(location.name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300)
                                    .padding()
                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                
                                Text(location.name)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .bold()
                                    .foregroundStyle(.brown)
                                    .padding()
                                
                                Text(location.description)
                                    .padding()
                                    .background(.brown)
                                
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
