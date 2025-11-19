//
//  SelectedView.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 11/5/25.
//

import CoreLocation
import MapKit
import SwiftUI
import UIKit

struct SelectedView: View {
    @ObservedObject var global: globalRestaurants
    @State private var selected: MKMapItem? = nil
    @State private var shareButtonSelected: Bool = false
    
    var onBack: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Back button
            HStack {
                Button {
                    onBack()
                } label: {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .foregroundColor(.white)

                Spacer()
                
                RestaurantShareButton(restaurant: selected)
            }
            
            // Pick random restaurant once when the view appears
            if let selected {
                
                Text("🍽️ Selected Restaurant")
                    .foregroundColor(.white)
                    .font(.system(size: 28, design: .rounded))
                    .bold()
                
                Text("Name: \(selected.name ?? "Unknown")")
                    .foregroundColor(.white)
                    .font(.system(size: 18, design: .rounded))
                    .bold()
                
                Text("Address: \(selected.formattedAddress)")
                    .foregroundColor(.white)
                    .font(.system(size: 18, design: .rounded))
                    .bold()
                
                Text("Phone: \(selected.phoneNumber ?? "Not available")")
                    .foregroundColor(.white)
                    .font(.system(size: 18, design: .rounded))
                    .bold()
                
                if let website = selected.url {
                    Text("Website: \(website.absoluteString)")
                        .foregroundColor(.white)
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                    
                } else {
                    Text("Website: Not available")
                        .foregroundColor(.white)
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                }
                
                
                Divider().padding(.vertical, 8)
                
                Map(
                    coordinateRegion: .constant(
                        MKCoordinateRegion(
                            center: selected.placemark.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // 0.01: Neighborhood Scale
                        )
                    ),
                    annotationItems: [selected.placemark.coordinate] // Item to pin
                ) { coordinate in
                    MapMarker(coordinate: coordinate, tint: .red) // Red pin
                }
                .onTapGesture {
                    selected.openInMaps(launchOptions: [ // Tells it to open the Apple Maps app when touched
                        MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
                    ])
                }
                
            } else {
                Text("No restaurant selected yet.")
            }
        }
        .padding()
        .background(Color(red: 0.9, green: 0.3, blue: 0.0))
        .onAppear {
            if selected == nil {
                selected = global.restaurantsList.randomElement()
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}


// Struct that is in charge of sharing the Restaurant Information
struct RestaurantShareButton: View {
    var restaurant: MKMapItem?
    
    var body: some View {
        ShareLink(item: ShareText()) {
            Image(systemName: "square.and.arrow.up")
                .font(.headline)
                .foregroundColor(.white)
        }
    }
    
    private func ShareText() -> String {
        if let restaurant = restaurant {
            let name = restaurant.name ?? "Unknown Restaurant"
            let address = restaurant.placemark.title ?? "Unknown Address"
            
            return "Let's go to this restaurant! \(name)\nAddress: \(address)"
        } else {
            return "No restaurant was selected."
        }
    }
}


#Preview {
    SelectedView(global: MockGlobalRestaurants())
}
