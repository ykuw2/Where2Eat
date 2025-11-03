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
    @State private var isLoading = false
    @State private var cuisineOrFoodError = false
    @State private var searchViewModel = LocationSearchViewModel()
    
    let radiusDistance: [Int] = [1, 5, 10, 20, 25, 50, 100]
    
    var body: some View {
            if !isLoading {
                ZStack(alignment: .top) {
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
                        
                        // TODO: Add logic for the MapKit
                        // For now it will just go to the LoadingView
                        Button("Go!") {
                            let trimmedCuisineOrFood = cuisineOrFood.trimmingCharacters(in: .whitespacesAndNewlines)
                            if trimmedCuisineOrFood.isEmpty || trimmedCuisineOrFood.count <= 2 {
                                cuisineOrFoodError = true
                            } else {
                                isLoading = true
                            }
                        }
                        .alert("Cuisine or Food Input is Invalid", isPresented: $cuisineOrFoodError) {
                            Button("Ok", role: .cancel) {}
                        }
                    }
                    
                    // TODO: Still UI Issues happening so fix this later
                    // AutoComplete suggestions
                    if !searchViewModel.completions.isEmpty {
                        ScrollView {
                            VStack {
                                ForEach(searchViewModel.completions, id: \.self) { item in
                                    VStack {
                                        Text(item.title)
                                            .font(.subheadline)
                                        
                                        if !item.subtitle.isEmpty {
                                            Text(item.subtitle)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding(.vertical, 4)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        location = item.title + (item.subtitle.isEmpty ? "" : ", \(item.subtitle)")
                                        searchViewModel.completions = []
                                    }
                                }
                            }
                        }
                    }
                }
            } else { // if isLoading is true
                    LoadingView()
                }
            }
    }

#Preview {
    InputView()
}
