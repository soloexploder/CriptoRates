//
//  NetworkManager.swift
//  CriptoRates
//
//  Created by Даниил Хантуров on 14.12.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    private let api = "https://data.messari.io/api/v1/assets/_/metrics"
    
    
    
    func fetchData(from coin: String, with complition: @escaping (Coin) -> Void) {
        guard let url = URL(string: "https://data.messari.io/api/v1/assets/\(coin)/metrics") else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let coin = try JSONDecoder().decode(Coin.self, from: data)
                DispatchQueue.main.async {
                    complition(coin)
                }
            } catch let error {
                print(error)
            }

        }.resume()
    }
}
