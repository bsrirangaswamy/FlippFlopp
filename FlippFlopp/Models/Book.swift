//
//  Book.swift
//  FlippFlopp
//
//  Created by Balakumaran Srirangaswamy on 5/19/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import UIKit
import ObjectMapper

class Book: Mappable {
    var amazonProductUurl: String?
    var ISBNs: [ISBN]?
    var primaryISBN10: Int?
    var contributorNote: String?
    var author: String?
    var sundayReviewLink: String?
    var bookReviewLink: String?
    var rankLastWeek: Int?
    var ageGroup: String?
    var buyLinks: [BuyLink]?
    var price: Int?
    var bookImageHeight: Int?
    var title: String?
    var contributor: String?
    var description: String?
    var asterisk: Int?
    var bookImage: String?
    var primaryISBN13: [BuyLink]?
    var dagger: Int?
    var articleChapterLink: Int?
    var firstChapterLink: String?
    var publisher: String?
    var rank: Int?
    var weeksOnList: Int?
    var bookImageWidth: Int?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        amazonProductUurl       <- map["amazon_product_url"]
        ISBNs                   <- map["isbns"]
        primaryISBN10           <- map["primary_isbn10"]
        contributorNote         <- map["contributor_note"]
        author                  <- map["author"]
        sundayReviewLink        <- map["sunday_review_link"]
        bookReviewLink          <- map["book_review_link"]
        rankLastWeek            <- map["rank_last_week"]
        ageGroup                <- map["age_group"]
        buyLinks                <- map["buy_links"]
        price                   <- map["price"]
        bookImageHeight         <- map["book_image_height"]
        title                   <- map["title"]
        contributor             <- map["contributor"]
        description             <- map["description"]
        asterisk                <- map["asterisk"]
        bookImage               <- map["book_image"]
        primaryISBN13           <- map["primary_isbn13"]
        dagger                  <- map["dagger"]
        articleChapterLink      <- map["article_chapter_link"]
        firstChapterLink        <- map["first_chapter_link"]
        publisher               <- map["publisher"]
        rank                    <- map["rank"]
        weeksOnList             <- map["weeks_on_list"]
        bookImageWidth          <- map["book_image_width"]
    }
}

struct ISBN: Mappable {
    var isbn10: Int?
    var isbn13: Int?

    init?(map: Map) {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        isbn10      <- map["isbn10"]
        isbn13      <- map["isbn13"]
    }
}

struct BuyLink: Mappable {
    var name: String?
    var url: String?
    
    init?(map: Map) {
        
    }
    
    // Mappable
    mutating func mapping(map: Map) {
        name    <- map["name"]
        url     <- map["url"]
    }
}


