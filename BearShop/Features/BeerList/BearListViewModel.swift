//
//  BeerListViewModel.swift
//  BeerShop
//
//  Created by Sushobhit.Jain on 04/10/21.
//

import Foundation

class BeerListViewModel {
    var updateList:()->Void = {}
    private var loading = true
    private var request: AnyObject?
    var beerList : [BeerElement]? {
        didSet {
            self.updateList()
        }
    }

    func fetchBeers(page:Int) {
        let beerListRequest = APIRequest(resource: BeerAPIResource())
        request = beerListRequest
        let param = ["page":"\(page)"]
        beerListRequest.load(param: param) { [weak self] (beers: [BeerElement]?) in
            guard let beers = beers else {
                return
            }
            guard self?.beerList != nil else {
                self?.beerList = beers
                return
            }
            self?.beerList! += beers
            
        }
    }
    
    
}
