//
//  StockModel.swift
//  ergeg4gt3ewwg
//
//  Created by Harnish Devani on 12/12/24.
//

import SwiftUI

import Foundation

struct Stock: Identifiable, Codable {
    var id = UUID()
    let symbol: String
    let price: Double
    let change: String
    let changePercent: String
    
    // Computed property for color-coding change
    var changeColor: Color {
        change.contains("+") ? .green : .red
    }
}

struct GlobalQuoteResponse: Codable {
    let globalQuote: GlobalQuote
    
    enum CodingKeys: String, CodingKey {
        case globalQuote = "Global Quote"
    }
}

struct GlobalQuote: Codable {
    let symbol: String
    let price: String
    let change: String
    let changePercent: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case price = "05. price"
        case change = "09. change"
        case changePercent = "10. change percent"
    }
}
