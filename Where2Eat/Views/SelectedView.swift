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
    
    var body: some View {
        VStack {
            if !global.restaurantsList.isEmpty {
                var restaurantName = global.restaurantsList.randomElement()?.name ?? "unknown"
                Text("The selection is: \(restaurantName)")
            } else {
                Text("Hello, World!")
            }
        }
    }
}

#Preview {
    SelectedView(global: MockGlobalRestaurants())
}
