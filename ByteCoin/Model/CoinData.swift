//
//  CoinData.swift
//  ByteCoin
//
//  Created by  Maksim Stogniy on 08.03.2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let rate: Double
    let asset_id_base: String
    let asset_id_quote: String
}
