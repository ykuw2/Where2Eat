//
//  LocationSearchViewModel.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 11/2/25.
//

import Combine
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate { // Obj-C APIs, search result updates
    @Published var queryFragment: String = "" {
        didSet {
            let trimmed = queryFragment.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty { // If the search text is empty then the completions should be empty
                completions = []
            } else {
                completer.queryFragment = trimmed
            }
        }
    }
    @Published var completions: [MKLocalSearchCompletion] = []
    
    private var completer: MKLocalSearchCompleter // MapKit object that does the searching
    
    override init() { // Overriding NSObject's default init()
        self.completer = MKLocalSearchCompleter()
        super.init()
        completer.delegate = self
        completer.resultTypes = .address
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) { // Called automatically whenever MapKit finishes getting autocomplete suggestions
        completions = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) { // Called when completer fails and just logs
        print("Error: \(error.localizedDescription)")
    }
    
    func updateSearch(_ input: String) { // Called whenever user types
        completer.queryFragment = input // for the completer
    }
}
