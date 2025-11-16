//
//  SelectedView.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 11/5/25.
//

import MapKit
import SwiftUI

struct SelectedView: View {
    @ObservedObject var global: globalRestaurants
    @State private var selected: MKMapItem? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Pick random restaurant once when the view appears
            if let selected {
                
                Text("🍽️ Selected Restaurant")
                    .font(.title.bold())
                
                Text("Name: \(selected.name ?? "Unknown")")
                    .font(.headline)
                
                Text("Address: \(selected.formattedAddress)")
                
                Text("Phone: \(selected.phoneNumber ?? "Not available")")
                
                if let website = selected.url {
                    Text("Website: \(website.absoluteString)")
                        .foregroundStyle(.blue)
                } else {
                    Text("Website: Not available")
                }

                Divider().padding(.vertical, 8)
                
            } else {
                Text("No restaurant selected yet.")
            }
        }
        .padding()
        .onAppear {
            if selected == nil {
                selected = global.restaurantsList.randomElement()
            }
        }
    }
}

#Preview {
    SelectedView(global: MockGlobalRestaurants())
}
