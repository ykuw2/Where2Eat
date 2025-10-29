//
//  IntroView.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 10/28/25.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        VStack {
            Text("Where2Eat")
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .padding()
            
            
            Text("Where will you go eat today?")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.9, green: 0.3, blue: 0.0))
        .ignoresSafeArea()
    }
}

#Preview {
    IntroView()
}
