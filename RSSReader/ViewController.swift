//
//  ViewController.swift
//  RSSReader
//
//  Created by Aliaksey Osipchyk on 3.02.23.
//

import UIKit
import FeedKit
class ViewController: UIViewController, XMLParserDelegate {
    var rss = [RSSFeedItem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let feedURL = URL(string: "https://lenta.ru/rss")!
        let parser = FeedParser(URL: feedURL)
        let result = parser.parse()
        switch result {
        case .success(let feed):
            switch feed {
            case let .atom(feed):       let entry = feed.entries?.first
            case let .rss(feed):        let item = feed.items?.first
                guard let item = item else {return}
                
                print(rss)
            case let .json(feed):       let item = feed.items?.first
            }
        case .failure(let error):
            print(error)
        }
    }
    
}
