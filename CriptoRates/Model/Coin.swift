//
//  Coin.swift
//  CriptoRates
//
//  Created by Даниил Хантуров on 14.12.2022.
//

import Foundation

struct Coin: Decodable {
    let data: CoinData
    
    var description: String {
        """
        Name: \(data.name )
        Price USD: \(String(format: "%.4f",data.marketData.priceUsd))
        Change last 24 hours: \(String(format: "%.4f",data.marketData.percentChangeLast24Hours))
        """
    }
}

struct CoinData: Decodable {
    let name: String
    let marketData: MarketData
    
   
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case marketData = "market_data"
    }
}

struct MarketData: Decodable {
    let priceUsd: Double
    let percentChangeLast24Hours: Double
    
    
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeLast24Hours = "percent_change_usd_last_24_hours"
    }
}
