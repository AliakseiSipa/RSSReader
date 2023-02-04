//
//  TableViewController.swift
//  RSSReader
//
//  Created by Aliaksey Osipchyk on 3.02.23.
//

import UIKit
import FeedKit

class TableViewController: UITableViewController {

    var feedItems = [RSSFeedItem]()
    var link = String()
    
    func request() {
        let feedURL = URL(string: "https://lenta.ru/rss")!
        let parser = FeedParser(URL: feedURL)
        let result = parser.parse()
        
        switch result {
        case .success(let feed):
            
            guard let feedItems = feed.rssFeed?.items else {
                return
            }
            for i in feedItems {
                self.feedItems.append(i)
            }
            
            self.tableView.reloadData()
            self.title = feed.rssFeed?.title
            
        case .failure(let error):
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
     
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        request()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feedItems.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let imageURL = feedItems[indexPath.row].link {
            self.link = imageURL
                }
        let url = URL(string: link)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewTableViewCell
        
        let item = feedItems[indexPath.row] as RSSFeedItem
        cell.titleLabel.text = item.title
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.lineBreakMode = .byWordWrapping
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let optionalDate = item.pubDate
        if let date = optionalDate {
            let dateString = dateFormatter.string(from: date)
            cell.dateLabel.text = dateString
        }
                        return cell
    }
}
