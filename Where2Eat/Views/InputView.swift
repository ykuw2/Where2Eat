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
    @State private var radius: Int = 0
    
    var body: some View {
        VStack {
            Text("Hello \(userName), what would you like to eat today?")
            
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
            
            // TODO: This will later be changed to a wheel of 1, 5, 10, 20... so on
            Text("Radius")
            TextField("Enter the radius in which you are willing to go for!", value: $radius, formatter: NumberFormatter())
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .padding()
            
            Button("Spin The wheel!") {}
        }
    }
}

#Preview {
    InputView()
}
