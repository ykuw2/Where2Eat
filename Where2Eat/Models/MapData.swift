//
//  MapData.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 11/6/25.
//

import Combine
import CoreLocation
import MapKit

func getRestaurants(foodOrCuisine: String, location: String, distance: Int, completion: @escaping ([MKMapItem]) -> Void) { // Completion is running the code at the very end
    let restaurantRequest = MKLocalSearch.Request() // MapKit request
    
    restaurantRequest.naturalLanguageQuery = location
    restaurantRequest.resultTypes = .address
    
    MKLocalSearch(request: restaurantRequest).start { response, error in
        // When search fails
        if let error = error {
            print("Location search error: \(error.localizedDescription)")
            completion([])
            return
        }
        
        // When search succeeds but no results are found (needs at least one)
        guard let response = response,
              let center = response.mapItems.first else {
            print("No address results found.")
            completion([])
            return
        }
        
        // Get coordinates of the found location
        let coordinate = center.placemark.coordinate
        
        // Using the distance here
        let meters = max(500, Double(distance) * 1609.34) // Using a minimum of 500 meters. MapKit uses meters.
        
        // The region of interest
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: meters,
            longitudinalMeters: meters
        )
        
        MKLocalSearch(request: restaurantRequest).start { restaurantResponse, error in
            if let error = error {
                print("Restaurant Search error: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let restaurantResponse = restaurantResponse else {
                print("No restaurants found.")
                completion([])
                return
            }
            
            // Returning the first 25 results.
            completion(Array(restaurantResponse.mapItems.prefix(25)))
        }
    }
}


class globalRestaurants: ObservableObject {
    @Published var restaurantsList: [MKMapItem] = []
}
