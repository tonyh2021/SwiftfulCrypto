//
//  XMarkButton.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-22.
//

import SwiftUI

struct XMarkButton: View {
    
    private var action: (() -> Void)?
    
    init(action: (() -> Void)? = nil) {
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            if let action = action {
                action()
            }
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
