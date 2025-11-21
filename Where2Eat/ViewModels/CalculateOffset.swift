//
//  CalculateOffset.swift
//  Where2Eat
//
//  Created by Yuki Kuwahara on 11/19/25.
//

import UIKit

func calculateOffset() -> PhoneSizeCategory {
    let h = UIScreen.main.bounds.height
    
    if h <= 667 {
        return .small
    }
    else if h >= 880 {
        return .large
    }
    else {
        return .standard
    }
}

func verticalOffset() -> CGFloat {
    switch calculateOffset() {
    case .small:
        return 250
    case .standard:
        return 325
    case .large:
        return 340
    }
}
