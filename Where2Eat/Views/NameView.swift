//
//  NameView.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 10/29/25.
//

import SwiftUI

struct NameView: View {
    @AppStorage("userName") private var userName: String = "" // Stores the name data into UserDefaults
    @State private var tempName: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            HStack{
                Text("What is your first name?")
                    .font(.system(size: 28, design: .rounded))
                    .foregroundColor(.white)
                    .bold()
            }
            
            TextField("Enter your name", text: $tempName)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Submit") {
                let trimmed = tempName.trimmingCharacters(in: .whitespacesAndNewlines) // This is so that it removes blank spaces
                if trimmed.isEmpty {
                    showAlert = true // Shows alert when name is blank
                } else {
                    userName = trimmed
                }
            }
            .foregroundColor(.white)
            .font(.system(size: 20, design: .rounded))
            .alert("Invalid Name", isPresented: $showAlert, actions: {
                Button("Ok", role: .cancel) {}
            }, message: {
                Text("Name cannot be blank.")
            }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.9, green: 0.3, blue: 0.0))
        .ignoresSafeArea()
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    NameView()
}
