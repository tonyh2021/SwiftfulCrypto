//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-23.
//

import Foundation
import SwiftUI

final class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
