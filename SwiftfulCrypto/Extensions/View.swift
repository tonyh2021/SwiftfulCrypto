//
//  SwiftUIView.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-14.
//

import SwiftUI

/**
 https://stackoverflow.com/questions/57053007/how-to-remove-the-top-safe-area-in-swiftui\
 
 This extension is needed because of deprecating edgesignoringsafearea for iOS 13.0–15.2
 https://developer.apple.com/documentation/swiftui/menu/edgesignoringsafearea(_:)
 */
public extension View {
    @ViewBuilder
    func expandViewOutOfSafeArea(_ edges: Edge.Set = .all) -> some View {
        if #available(iOS 14, *) {
            self.ignoresSafeArea(edges: edges)
        } else {
            self.edgesIgnoringSafeArea(edges) // deprecated for iOS 13.0–15.2, look upper
        }
    }
}
