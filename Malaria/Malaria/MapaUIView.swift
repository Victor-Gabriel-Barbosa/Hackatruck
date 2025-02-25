//
//  MapaUIView.swift
//  Malaria
//
//  Created by Turma01-27 on 25/02/25.
//


import SwiftUI
import MapKit

struct Location: Identifiable, Hashable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let description: String
    let range: Double
    
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
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -15.8267, longitude: -47.9218),
        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    )
    
    let locations = [
        Location(coordinate: CLLocationCoordinate2D(latitude: -3.10719, longitude: -47.9218), description: "Região Amazônica", range: 10),
        Location(coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), description: "Cidade famosa nos EUA", range: 32),
        Location(coordinate: CLLocationCoordinate2D(latitude: 35.682839, longitude: 139.759455), description: "Capital do Japão", range: 43)
    ]
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            VStack {
                VStack {
                    VStack {
                        ZStack {
                            Color.gray.edgesIgnoringSafeArea(.all)
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 210, height: 210)
                                .offset(CGSize(width: 0, height: 120.0))
                        }
                        .frame(height: 200)
                    }
                    
                    Spacer()
                    
                    Text("Pontos mais afetados")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                }
                
                VStack {
                    MapViewWithCircles(
                        region: $region,
                        locations: locations
                    )
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
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
        // Atualiza a região
        mapView.setRegion(region, animated: true)
        
        // Remove sobreposições e anotações antigas
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        // Adiciona novas anotações e círculos
        for location in locations {
            // Adiciona o pin
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.subtitle = location.description
            mapView.addAnnotation(annotation)
            
            // Adiciona o círculo
            let circleRadius = location.range * 1000
            let circle = MKCircle(center: location.coordinate, radius: circleRadius)
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
        
        // Customiza o marcador
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
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
        
        // Customiza o círculo
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
        
        // Atualiza a região quando o mapa é movido pelo usuário
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
