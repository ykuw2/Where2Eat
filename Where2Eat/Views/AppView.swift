//
//  AppView.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 10/29/25.
//

import SwiftUI

struct AppView: View {
    @State private var showIntro: Bool = true
    @AppStorage("userName") private var userName = ""

    var body: some View {
            if showIntro {
                IntroView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation(.easeOut(duration: 0.5)) {
                                showIntro = false
                            }
                        }
                    }
            } else {
                ZStack { // We are using ZStack here so that when NameView -> InputView we can have a transition
                    if userName.isEmpty {
                        NameView()
                            .transition(.opacity)
                    } else {
                        InputView()
                            .transition(.opacity)
                    }
                }
                .animation(.easeOut(duration: 0.5), value: userName)
            }
        }
    }

#Preview {
    AppView()
}
