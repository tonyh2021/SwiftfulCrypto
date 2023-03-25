//
//  LauchContainerView.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-25.
//

import SwiftUI

struct LauchContainerView: View {
    
    @State private var showLaunchView: Bool = true
    
    var body: some View {
        ZStack {
            if showLaunchView {
                LaunchView(showLaunchView: $showLaunchView)
                    .transition(.move(edge: .leading))
            }
        }
    }
}

struct LauchContainerView_Previews: PreviewProvider {
    static var previews: some View {
        LauchContainerView()
    }
}
