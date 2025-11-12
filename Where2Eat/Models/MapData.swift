//
//  MapData.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 11/6/25.
//

import Combine
import CoreLocation
import MapKit

func getRestaurants(foodOrCuisine: String, location: String, distance: Int, completion: @escaping ([MKMapItem]) -> Void) {
    
    // First, we need to get the coordinate of the user-entered location
    let locationRequest = MKLocalSearch.Request()
    locationRequest.naturalLanguageQuery = location
    locationRequest.resultTypes = .address
    
    MKLocalSearch(request: locationRequest).start { response, error in
        if let error = error {
            print("Location search error: \(error.localizedDescription)")
            completion([])
            return
        }
        
        guard let response = response,
              let coordinate = response.mapItems.first?.placemark.coordinate else {
            print("No location results found.")
            completion([])
            return
        }
        
        // Now, we can search
        let restaurantRequest = MKLocalSearch.Request()
        restaurantRequest.naturalLanguageQuery = "\(foodOrCuisine) restaurant"
        restaurantRequest.resultTypes = [.pointOfInterest]
        restaurantRequest.region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: max(500, Double(distance) * 1609.34),
            longitudinalMeters: max(500, Double(distance) * 1609.34)
        )
        
        MKLocalSearch(request: restaurantRequest).start { restaurantResponse, error in
            if let error = error {
                print("Restaurant search error: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let restaurantResponse = restaurantResponse else {
                print("No restaurants found.")
                completion([])
                return
            }
            
            // Return the first 25 restaurants
            completion(Array(restaurantResponse.mapItems.prefix(25)))
        }
    }
}


class globalRestaurants: ObservableObject {
    @Published var restaurantsList: [MKMapItem] = []
}
