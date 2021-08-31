//
//  NewsViewControlle.swift
//  Sber RSS
//
//  Created by Влад on 07.10.2020.
//  Copyright © 2020 Влад. All rights reserved.
//

import Foundation
import UIKit
struct Post {
    var title: String!
    var link: String!
    var date: String!
}

class NewsViewController: UIViewController, XMLParserDelegate, UITableViewDelegate {
    
    var sourse: URL!
    
    var parser = XMLParser()
    var currentElement = ""
    var foundCharacters = ""
    var currentData = [String:String]()
    var parsedData = [[String:String]]()
    var isHeader = true
    
    var posts:[Post] = []
    var tempPost: Post? = nil
    var tempElement: String?
    
    var headerView: UIView!
    var titleLabel: UILabel!
    var newsTable: UITableView!
    var modelArray = [NewsCellModel]()
    let cellIdentifier = "newsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTable = UITableView()
        newsTable.dataSource = self
        //newsTable.register(NewsCell.self, forCellReuseIdentifier: cellIdentifier)
        //newsTable.delegate = self
        sourse = URL(string: "http://lenta.ru/rss")
        headerView = UIView()
        headerView.backgroundColor = UIColor.orange
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(headerView)
        
        titleLabel = UILabel()
        titleLabel.text = "RSS News"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 30)
        headerView.addSubview(titleLabel)
        
        
        setUpNewsTable()
        
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
               headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
               headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
               headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
               headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
               
               titleLabel.translatesAutoresizingMaskIntoConstraints = false
               titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
               titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
               titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.4).isActive = true
               titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5).isActive = true
        
                
                
        
        //parser = XMLParser(contentsOf:(URL(string:"http://lenta.ru/rss")!))!
        //parser.delegate = self
        //parser.parse()
        //newsTable.reloadData()
        //print(posts)
        startParsingUrl(rssURL: sourse)
        fillNewsModel(parsedData)
        newsTable.reloadData()
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" || currentElement == "entry"{
            if isHeader == false{
                parsedData.append(currentData)
            }
            isHeader = false
        }
        if isHeader == false {
            if currentElement == "media:thumbnail" || currentElement == "media:content"{
                foundCharacters += attributeDict["url"]!
            }
        }
    }
    
    func parser(_ : XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty{
            foundCharacters = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
            currentData[currentElement] = foundCharacters
            foundCharacters = ""
        }
    }
    
    func parser(_ : XMLParser, foundCharacters string: String) {
        if isHeader == false {
            if currentElement == "title" || currentElement == "link" || currentElement == "description"{
                foundCharacters += string
                //foundCharacters = foundCharacters.deleteHTML(tags: ["a","p","div","img"])
            }
        }
    }
    
    
    func startParsingUrl(rssURL: URL){
        let parser = XMLParser(contentsOf: rssURL)
        parser?.delegate = self
        if let flag = parser?.parse(){
            parsedData.append(currentData)
            //completion(flag)
        }
    }
    
    func setUpNewsTable(){
        self.view.addSubview(newsTable)
        newsTable.translatesAutoresizingMaskIntoConstraints = false
                newsTable.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
                newsTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        newsTable.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        newsTable.register(NewsCell.self, forCellReuseIdentifier: cellIdentifier)
        newsTable.rowHeight = 300
    }
    
    func fillNewsModel(_ mass: [[String:String]]) {
    modelArray = []
    var a = 0
    for elm in mass {
        let model = NewsCellModel()
        model.title = mass[a]["title"]
        model.description = parsedData[a]["description"]
        modelArray.append(model)
        a+=1
    }
    }
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewsCell
        cell.fillCell(with: modelArray[indexPath.row])
    
        cell.descriptionLabel.text = parsedData[indexPath.row]["description"]
        cell.titleLabel.text = parsedData[indexPath.row]["title"]
        cell.textLabel?.text = parsedData[indexPath.row]["title"]
        cell.detailTextLabel?.text = parsedData[indexPath.row]["description"]
        cell.titleLabel.topAnchor.constraint(equalTo: cell.textLabel!.bottomAnchor, constant: 1).isActive = true
        cell.titleLabel.backgroundColor = UIColor.red
        cell.textLabel?.isHidden = true
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(parsedData[indexPath.row]["link"]!)
    }
    
}


