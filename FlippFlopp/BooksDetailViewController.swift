//
//  BooksDetailViewController.swift
//  FlippFlopp
//
//  Created by Balakumaran Srirangaswamy on 5/20/19.
//  Copyright © 2019 Bala. All rights reserved.
//

import UIKit

class BooksDetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bestSellerRankLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var weeksOnListLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    var bookObj: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set Navigation Bar Title
        self.title = "kBookInfo".localized
        
        if let bookRef = bookObj {
            titleLabel.text = "kTitle".localized + String(bookRef.title ?? "")
            bestSellerRankLabel.text = "kBestSellerRank".localized + String(bookRef.rank ?? 0)
            authorLabel.text = "kAuthor".localized + String(bookRef.author ?? "")
            publisherLabel.text = "kPublisher".localized + String(bookRef.publisher ?? "")
            weeksOnListLabel.text = "kNumberOfWeeks".localized + String(bookRef.weeksOnList ?? 1)
            synopsisLabel.text = "kSynopsis".localized + String(bookRef.description ?? "")
            if let imageData = bookRef.bookImageData {
                bookImageView.image = UIImage(data: imageData)
            }
        }
    }

}
