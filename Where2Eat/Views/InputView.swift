//
//  InputView.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 10/29/25.
//

import SwiftUI
import MapKit

struct InputView: View {
    @AppStorage("userName") private var userName: String = ""
    @State private var cuisineOrFood: String = ""
    @State private var location: String = ""
    @State private var radius: Int = 1
    @State private var isLoading: Bool = false
    @State private var cuisineOrFoodError: Bool = false
    @State private var toSelectedView: Bool = false
    @State private var searchViewModel = LocationSearchViewModel()
    @ObservedObject var global = globalRestaurants()
    
    let radiusDistance: [Int] = [1, 5, 10, 20, 25, 50, 100]
    
    var body: some View {
            if !isLoading {
                ZStack {
                    VStack {
                        Text("Hello \(userName), what would you like to eat today?")
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("Cuisine or Food")
                        TextField("Enter your cuisine of food you're craving", text: $cuisineOrFood)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.asciiCapable)
                            .padding()
                        
                        
                        Text("Location")
                        TextField("Enter your address, city, or a zip code", text: $location)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.default)
                            .padding()
                            .onChange(of: location) {
                                searchViewModel.updateSearch(location)
                            }
                        
                        Text("Radius")
                        Picker("Radius", selection: $radius) {
                            ForEach(radiusDistance, id: \.self) { distance in
                                Text("Within \(distance) \(distance == 1 ? "mile" : "miles")")
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Button("Go!") {
                            global.restaurantsList = [] // Empty the previous restaurants first
                            let trimmedCuisineOrFood = cuisineOrFood.trimmingCharacters(in: .whitespacesAndNewlines)
                            if trimmedCuisineOrFood.isEmpty || trimmedCuisineOrFood.count <= 2 {
                                cuisineOrFoodError = true
                            } else {
                                // Running the getRestaurant Function here
                                getRestaurants(foodOrCuisine: cuisineOrFood, location: location, distance: radius) { items in
                                    DispatchQueue.main.async {
                                        if items.isEmpty {
                                            // Throw an error here
                                        } else {
                                            isLoading = true
                                            global.restaurantsList = items
                                        }
                                    }
                                }
                            }
                        }
                        .alert("Cuisine or Food Input is Invalid", isPresented: $cuisineOrFoodError) {
                            Button("Ok", role: .cancel) {}
                        }
                    }
                    // AutoComplete suggestions (Floating from ZStack)
                    if !searchViewModel.completions.isEmpty && !location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        ScrollView {
                            VStack(spacing: 0) { // Removes gaps between each item
                                ForEach(searchViewModel.completions, id: \.title) { item in
                                    VStack {
                                        Text(item.title)
                                            .font(.subheadline)
                                        
                                        if !item.subtitle.isEmpty {
                                            Text(item.subtitle)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding(.vertical, 10)
                                    .background(Color.white)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        location = item.title + (item.subtitle.isEmpty ? "" : ", \(item.subtitle)")
                                        searchViewModel.completions = []
                                    }
                                }
                            }
                        }
                        // TODO: Hardcoded the offset for now but use GeometeryReader or some sorts when dealing with UI elements later
                        .offset(y: 450)
                    }
                }
            } else { // if isLoading is true
                if !toSelectedView {
                    LoadingView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() /*+ 5*/) {
                                toSelectedView = true
                                }
                            }
                    } else {
                        SelectedView(global: global)
                        }
                    }
                }
        }

#Preview {
    InputView()
}
