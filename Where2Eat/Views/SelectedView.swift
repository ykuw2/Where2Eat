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
                ForEach(global.restaurantsList, id: \.self) { restaurant in
                    Text("\(String(describing: restaurant.name))") // Keep it type safe... for now
                }
            } else {
                Text("Hello, World!")
            }
        }
    }
}

//#Preview {
//    SelectedView()
//}
