//
//  ContentView.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background.expandViewOutOfSafeArea()
            VStack(spacing: 40) {
                Text("Accent Color").foregroundColor(Color.theme.accent)
                Text("Secondary Color").foregroundColor(Color.theme.secondary)
                Text("Red Color").foregroundColor(Color.theme.red)
                Text("Green Color").foregroundColor(Color.theme.green)
            }.font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
