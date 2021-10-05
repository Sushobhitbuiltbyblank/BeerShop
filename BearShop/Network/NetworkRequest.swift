//
//  NetworkRequest.swift
//  BeerShop
//
//  Created by Sushobhit.Jain on 04/10/21.
//

import Foundation
import UIKit

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func load(param:[String:Any], withCompletion completion: @escaping (ModelType?) -> Void)
}

let sharedDelegate = UIApplication.shared.delegate as? AppDelegate
extension NetworkRequest {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                if let errorMsg = error?.localizedDescription {
                    let alert = UIAlertController.init(title: "Message", message: errorMsg, preferredStyle: .alert)
                    let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
                    alert.addAction(alertAction)
                    sharedDelegate?.window?.rootViewController?.present(alert, animated: false, completion: nil)
                }
                completion(nil)
                return
            }
            completion(self?.decode(data))
        })
        task.resume()
    }
}

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> [Resource.ModelType]? {
        let list = try? JSONDecoder().decode([Resource.ModelType].self, from: data)
        print(data.printJSON())
        return list
    }
    
    func load(param:[String:Any], withCompletion completion: @escaping ([Resource.ModelType]?) -> Void) {
        load(resource.getURL(param), withCompletion: completion)
    }
}

protocol APIResource {
    associatedtype ModelType: Codable
    var methodPath: String { get }
}

extension APIResource {
    
    func getURL(_ queryItems:[String:Any]) -> URL {
        var components = URLComponents()
        components.scheme = BeerAPI.scheme
        components.host = BeerAPI.host
        components.path = BeerAPI.path + methodPath
        var urlQueryItems = [URLQueryItem]()
        for (key,value) in queryItems {
            urlQueryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        components.queryItems = urlQueryItems
        return components.url!
    }
}

struct BeerAPI {
    static let scheme = "https"
    static let host = "api.punkapi.com"
    static let path = "/v2"
}
// https://api.punkapi.com/v2/beers?page=N

