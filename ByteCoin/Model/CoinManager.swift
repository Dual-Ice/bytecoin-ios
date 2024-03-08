//
//  CoinManager.swift
//  ByteCoin
//
//  Updated by Maksim Stogniy on 08.03.2024
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinInfo(_ manager: CoinManager, coinModel: CoinModel)
    func didFail(with error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        perfomRequest(for: "\(baseURL)/\(currency)?apikey=\(apiKey)")
    }
    
    func perfomRequest(for urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    self.delegate?.didFail(with: error!)
                    return
                }
                
                if let safeData = data {
                    if let coinModel = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCoinInfo(self, coinModel: coinModel)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            return CoinModel(
                coin: decodedData.asset_id_base,
                rate: decodedData.rate,
                currency: decodedData.asset_id_quote
            )
        } catch {
            print(error)
            delegate?.didFail(with: error)
            return nil
        }
    }

    
}
