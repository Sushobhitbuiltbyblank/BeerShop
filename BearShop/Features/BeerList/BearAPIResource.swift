//
//  BeerAPIResource.swift
//  BeerShop
//
//  Created by Sushobhit.Jain on 04/10/21.
//

import Foundation

struct BeerAPIResource: APIResource {
    typealias ModelType = BeerElement
    let methodPath = "/beers"
}
