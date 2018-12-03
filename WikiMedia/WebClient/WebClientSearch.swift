//
//  WebClientSearch.swift
//  CraftBeer
//
//  Created by Jamil on 1/9/18.
//  Copyright © 2018 Jamil. All rights reserved.
//

import UIKit
import Alamofire

class WebClientSearch: NSObject {
    private override init() { }
    public static let shared = WebClientSearch()
    
    //https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch=Nelson%20Mandela&utf8=&format=json
    //search
    var action: String = ""
    var list: String = ""
    var srsearch: String = ""
    var format: String = ""
    
    var searchList:[Search] = []
    
    //get parameter
    func getParam() -> Parameters{
        
        let param: Parameters = [
            "action": self.action,
            "list": self.list,
            "srsearch": self.srsearch,
            "format": self.format,
            ]
        return param
    }
    
   
    func setSearchList(list:NSArray){
        searchList.removeAll()
        if list.count == 0 {return}
        
        for index in 0...list.count-1 {
            print("\(index)")
            let responseDic:Dictionary = list[index] as! [String:Any]
            let search = Search()
            
            search.ns = responseDic["ns"] as! NSNumber
            search.title = responseDic["title"] as! String
            search.snippet = responseDic["snippet"] as! String
            search.timestamp = responseDic["timestamp"] as! String
            
//            search.pageid = Double(responseDic["pageid"] as! NSNumber)!
//            search.size = Double(responseDic["size"] as! String)!
//            search.wordcount = Double(responseDic["wordcount"] as! String)!
            
            searchList.append(search)
            
        }
    }
    
}
