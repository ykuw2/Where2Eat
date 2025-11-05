//
//  LoadingView.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 11/1/25.
//

import SwiftUI

struct LoadingView: View {
    @State private var bounce = false
    
    var body: some View {
        VStack {
            ProgressView() // The Spinning Circle View that we all see
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.8)
                .offset(y: bounce ? -3 : 3)
                .animation(
                    .easeInOut(duration: 0.5)
                    .repeatForever(autoreverses: true),
                    value: bounce
                )
                .onAppear {
                    bounce = true
                }
            
            Spacer()
                .frame(height: 50)
            
            Text("🍽️ Cooking it up just for you...")
                .foregroundStyle(.white)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
         .background(Color(red: 0.9, green: 0.3, blue: 0.0))
         .ignoresSafeArea()
    }
}

#Preview {
    LoadingView()
}
