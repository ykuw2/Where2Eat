//
//  InputView.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 10/29/25.
//

import SwiftUI

struct InputView: View {
    @AppStorage("userName") private var userName: String = ""
    @State private var cuisineOrFood: String = ""
    @State private var location: String = ""
    @State private var radius: Int = 1
    @State private var isLoading = false
    
    let radiusDistance: [Int] = [1, 5, 10, 20, 25, 50, 100]
    
    var body: some View {
        ZStack {
            if !isLoading {
                VStack {
                    Text("Hello \(userName), what would you like to eat today?")
                    
                    Spacer()
                        .frame(height: 100)
                    
                    // TODO: Make sure that the two fields below are not empty
                    Text("Cuisine or Food")
                    TextField("Enter your cuisine of food you're craving", text: $cuisineOrFood)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.default)
                        .padding()
                    
                    Text("Location")
                    TextField("Enter your address, city, or a zip code", text: $location)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.default)
                        .padding()
                    
                    Text("Radius")
                    Picker("Radius", selection: $radius) {
                        ForEach(radiusDistance, id: \.self) { distance in
                            Text("Within \(distance) \(distance == 1 ? "mile" : "miles")")
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Spacer()
                        .frame(height: 100)
                    
                    // TODO: Add logic for the MapKit
                    // For now it will just go to the LoadingView
                    Button("Go!") {
                        isLoading = true
                    }
                }
            } else { // if isLoading is true
                LoadingView()
            }
        }
    }
}

#Preview {
    InputView()
}
