//
//  MapaUIView.swift
//  Malaria
//
//  Created by Turma01-27 on 25/02/25.
//

import SwiftUI
import MapKit

// Representa uma localização no mapa
struct Location: Identifiable, Hashable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let description: String
    let range: Double
    let zoomLevel: Double
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id &&
           lhs.coordinate.latitude == rhs.coordinate.latitude &&
           lhs.coordinate.longitude == rhs.coordinate.longitude &&
           lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(coordinate.latitude)
        hasher.combine(coordinate.longitude)
        hasher.combine(description)
    }
}

struct MapaUIView: View {
    // Define a região inicial do mapa
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -15.8267, longitude: -47.9218),
        span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
    )
    
    @State private var selectedLocationIndex = 0
    
    // Lista de locais afetados
    let locations = [
        Location(coordinate: CLLocationCoordinate2D(latitude: -3.1187, longitude: -60.0289), description: "Região Amazônica", range: 1000, zoomLevel: 20),
        Location(coordinate: CLLocationCoordinate2D(latitude: -3.3060, longitude: 24.4989), description: "África", range: 2000, zoomLevel: 40),
        Location(coordinate: CLLocationCoordinate2D(latitude: 24.9154, longitude: 78.4779), description: "Ásia", range: 1500, zoomLevel: 30),
        Location(coordinate: CLLocationCoordinate2D(latitude: -5.567377103761737, longitude: 141.30676005040968), description: "Papua-Nova Guiné", range: 800, zoomLevel: 30)
    ]
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                VStack {
                    ZStack {
                        Color.gray.edgesIgnoringSafeArea(.all)
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 210, height: 210)
                            .offset(y: 120)
                    }
                    .frame(height: 200)
                    
                    Spacer()
                    
                    Text("Pontos mais afetados")
                        .font(.title)
                        .bold()
                    
                    // Seleciona uma localização
                    Picker("Selecione uma localização", selection: $selectedLocationIndex) {
                        ForEach(0..<locations.count, id: \ .self) { index in
                            Text(locations[index].description).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .onChange(of: selectedLocationIndex) { newValue in
                        let selectedLocation = locations[newValue]
                        region = MKCoordinateRegion(
                            center: selectedLocation.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: selectedLocation.zoomLevel, longitudeDelta: selectedLocation.zoomLevel)
                        )
                    }
                    
                    Spacer()
                }
                
                // Exibe o mapa
                MapViewWithCircles(region: $region, locations: locations)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            // Botão para reiniciar visão global
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: -15.8267, longitude: -47.9218),
                            span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)
                        )
                    }) {
                        Image(systemName: "globe")
                            .font(.title)
                            .padding()
                            .background(Circle().fill(Color.white))
                            .shadow(radius: 3)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            // Inicializa com a primeira localização
            let initialLocation = locations[selectedLocationIndex]
            region = MKCoordinateRegion(
                center: initialLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: initialLocation.zoomLevel, longitudeDelta: initialLocation.zoomLevel)
            )
        }
    }
}

struct MapViewWithCircles: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    let locations: [Location]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        // Atualiza a região do mapa
        mapView.setRegion(region, animated: true)
        
        // Remove elementos anteriores
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        // Adiciona novos marcadores e círculos
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = location.description
            mapView.addAnnotation(annotation)
            
            let circle = MKCircle(center: location.coordinate, radius: location.range * 1000)
            mapView.addOverlay(circle)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewWithCircles
        
        init(_ parent: MapViewWithCircles) {
            self.parent = parent
        }
        
        // Personaliza o marcador
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation { return nil }
            
            let identifier = "locationPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
        
        // Personaliza o círculo
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circleOverlay = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circleOverlay)
                renderer.fillColor = UIColor.blue.withAlphaComponent(0.2)
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth = 2
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        // Atualiza a região ao mover o mapa
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            DispatchQueue.main.async {
                self.parent.region = mapView.region
            }
        }
    }
}

#Preview {
    MapaUIView()
}
