//
//  Data+Extension.swift
//  BeerShop
//
//  Created by Sushobhit.Jain on 04/10/21.
//

import Foundation

extension Data
{
    func printJSON()
    {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8)
        {
            print(JSONString)
        }
    }
}
