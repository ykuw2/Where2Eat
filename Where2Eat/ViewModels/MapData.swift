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
            latitudinalMeters: Double(distance) * 1609.34,
            longitudinalMeters: Double(distance) * 1609.34
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
            
            // Strictly filter by actual distance
            let maxDistanceMeters = Double(distance) * 1609.34
            let userLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let filteredResults = restaurantResponse.mapItems.filter { item in
                let restaurantLocation = CLLocation(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                
                return restaurantLocation.distance(from: userLocation) <= maxDistanceMeters
            }
            
            // Return the first 25 restaurants
            completion(Array(filteredResults.prefix(25)))
        }
    }
}


class globalRestaurants: ObservableObject {
    @Published var restaurantsList: [MKMapItem] = []
}


// Creating a Mock globalRestaurants object for testing
class MockGlobalRestaurants: globalRestaurants {
    override init() {
        super.init()
        
        let item1 = MKMapItem(placemark: MKPlacemark(coordinate: .init(latitude: 32.7157, longitude: -117.1611)))
        item1.name = "Pizza Palace"

        let item2 = MKMapItem(placemark: MKPlacemark(coordinate: .init(latitude: 32.7157, longitude: -117.1610)))
        item2.name = "Sushi World"

        self.restaurantsList = [item1, item2]
    }
}


extension MKMapItem {
    // Formatted Address
    var formattedAddress: String {
        let placemark = self.placemark
        
        // Combine street number + street
        let street = [placemark.subThoroughfare, placemark.thoroughfare]
            .compactMap { $0 }
            .joined(separator: " ")
        
        // Combine state + ZIP with a space
        let stateZip = [placemark.administrativeArea, placemark.postalCode]
            .compactMap { $0 }
            .joined(separator: " ")
        
        // Join street, city, and state + ZIP with commas
        return [street, placemark.locality, stateZip]
            .compactMap { $0?.isEmpty == false ? $0 : nil }
            .joined(separator: ", ")
    }
}


extension CLLocationCoordinate2D: Identifiable { // Needed since annotationItems need to conform to "Identifiable"
    public var id: String { "\(latitude),\(longitude)" }
}


