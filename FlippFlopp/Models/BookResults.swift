//
//  DataResults.swift
//  FlippFlopp
//
//  Created by Balakumaran Srirangaswamy on 5/19/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import UIKit
import ObjectMapper

class BookResults: Mappable {
    var publishedDate: String?
    var listNameEncoded: String?
    var updated: String?
    var previousPublishedDate: String?
    var publishedDateDescription: String?
    var bestsellersDate: String?
    var normalListEndsAt: Int?
    var listName: String?
    var displayName: String?
    var nextPublishedDate: String?
    var books: [Book]?
    var status: String?
    var numResults: Int?
    var lastModified: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        publishedDate               <- map["published_date"]
        listNameEncoded             <- map["list_name_encoded"]
        updated                     <- map["updated"]
        previousPublishedDate       <- map["previous_published_date"]
        publishedDateDescription    <- map["published_date_description"]
        bestsellersDate             <- map["bestsellers_date"]
        normalListEndsAt            <- map["normal_list_ends_at"]
        listName                    <- map["list_name"]
        displayName                 <- map["display_name"]
        nextPublishedDate           <- map["next_published_date"]
        books                       <- map["books"]
        status                      <- map["status"]
        numResults                  <- map["num_results"]
        lastModified                <- map["last_modified"]
    }
}
