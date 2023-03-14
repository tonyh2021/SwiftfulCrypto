//
//  Color.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-14.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondary = Color("SecondaryColor")
}

struct LaunchTheme {
    let launchAccent = Color("LaunchAccentColor")
    let launchBackground = Color("LaunchBackgroundColor")
}
