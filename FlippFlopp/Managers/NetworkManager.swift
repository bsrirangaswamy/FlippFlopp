//
//  NetworkManager.swift
//  FlippFlopp
//
//  Created by Balakumaran Srirangaswamy on 5/19/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

public enum NetworkCommands: String {
    case listNames = "/lists/names.json?"
    case listData = "/lists/current/hardcover-fiction.json?"
    case bookReviewISBN = "/reviews.json?isbn="
    case bookReviewAuthor = "/reviews.json?author="
}

let bestSellerBooksFetchedNotification = "com.PriBa.FlippFlopp.bestSellerBooksFetchedNotification"

class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    
    func executeRequest(urlString: String, isbn: Int?, author: String?) {
        let createURLString = getBaseAPI() + urlString + "api-key=" + getAPIKey()
        
        print("Request string = \(createURLString)")
        
        Alamofire.request(createURLString)
            .validate()
            .responseData { (responseData) in
            if let data = responseData.data {
                do {
                    let jsonValue = try JSON(data: data)
                    DataManager.sharedInstance.bestSellerResults = Mapper<BookResults>().map(JSONObject: jsonValue["results"].rawValue)
                    DataManager.sharedInstance.saveStorage()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: bestSellerBooksFetchedNotification), object: self)

                } catch {
                    print("JSON fetch error = \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func getBaseAPI() -> String {
        return "https://api.nytimes.com/svc/books/v3"
    }
    
    private func getAPIKey() -> String {
        return "kApiKey".localized
    }

}
