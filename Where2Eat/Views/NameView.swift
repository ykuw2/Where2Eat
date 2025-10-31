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
                    .font(.headline)
                Spacer()
            }.padding(.leading, 20)
            
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
            .alert("Invalid Name", isPresented: $showAlert, actions: {
                Button("Ok", role: .cancel) {}
            }, message: {
                Text("Name cannot be blank.")
            }
            )
        }
    }
}

#Preview {
    NameView()
}
