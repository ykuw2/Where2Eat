//
//  LoadingView.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 11/1/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView() // The Spinning Circle View that we all see
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2)
            
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
