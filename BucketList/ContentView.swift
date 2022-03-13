//
//  ContentView.swift
//  BucketList
//
//  Created by simge on 9.03.2022.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @State private var mapRegion =  MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @State private var locations = [Location]() //Location.swift
    
    @State private var selectedPlace:Location?
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 40, height: 40)
                            .background(.white)
                            .clipShape(Circle())

                        Text(location.name)
                            .fixedSize()
                    }
                    //**sheet
                    .onTapGesture {
                        selectedPlace = location
                    }
                }
            }
            .ignoresSafeArea()
            
            Circle()
                .fill(.red)
                .opacity(0.3)
                .frame(width:32, height: 32)
            
            VStack{
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Button(){
                        //create a new location
                        let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                        locations.append(newLocation)
                        
                    }label:{
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        //EditView
        .sheet(item:$selectedPlace){place in
            EditView(location: place) { newLocation in
                if let index = locations.firstIndex(of: place) {
                    locations[index] = newLocation
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
