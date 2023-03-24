//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-24.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
