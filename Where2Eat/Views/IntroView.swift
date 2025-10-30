//
//  IntroView.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 10/28/25.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                    .frame(height: geo.size.height * 0.4)

                Text("Where2Eat")
                    .font(.system(size: 40, design: .rounded))
                    .foregroundColor(.white)
                    .bold()
        
                Text("Where will you go eat today?")
                    .font(.system(size: 20, design: .rounded))
                    .foregroundColor(.white)
                    .offset(y: geo.size.height * 0.1)
                
                Spacer()
            }
            .frame(width: geo.size.width)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.9, green: 0.3, blue: 0.0))
        .ignoresSafeArea()
    }
}

#Preview {
    IntroView()
}
