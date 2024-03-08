//
//  CoinModel.swift
//  ByteCoin
//
//  Created by  Maksim Stogniy on 08.03.2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let coin: String
    let rate: Double
    let currency: String
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
