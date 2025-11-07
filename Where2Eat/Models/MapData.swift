//
//  MapData.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 11/6/25.
//

import MapKit

func getRestaurants(foodOrCuisine: String, location: String, distance: Int, completion: @escaping ([MKMapItem]) -> Void) {
    let locationRequest = MKLocalSearch.Request()
    
    locationRequest.naturalLanguageQuery = location
    locationRequest.resultTypes = .address // Only get the .address
    
    MKLocalSearch(request: locationRequest).start { response, error in
        if let error = error {
            print("Location search error: \(error.localizedDescription)")
            completion([])
            return
        }
        
        guard let response = response else {
            print("No results found.")
            completion([])
            return
        }
        
        let items: [MKMapItem] = response.mapItems
        completion(items)
        
    }
}
