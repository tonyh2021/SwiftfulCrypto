//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-16.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
