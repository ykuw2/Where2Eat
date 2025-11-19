//
//  ViewExtension.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 11/18/25.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
