//
//  LinkAdaptor.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-28.
//

import SwiftUI

struct LinkAdaptor: View {
    
    let title: String
    let destination: URL
    
    init(_ title: String, destination: URL) {
        self.title = title
        self.destination = destination
    }
    
    var body: some View {
        if #available(iOS 14.0, *) {
            Link(title, destination: destination)
        } else {
            Button(action: {
                UIApplication.shared.open(destination)
            }) {
                Text(title)
            }
        }
    }
}

struct LinkAdaptor_Previews: PreviewProvider {
    static var previews: some View {
        LinkAdaptor("title", destination: URL(string: "https://www.google.com")!)
    }
}
