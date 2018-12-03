//
//  SearchViewController.swift
//  CraftBeer
//
//  Created by Jamil on 11/9/18.
//  Copyright © 2018 Jamil. All rights reserved.
//

import UIKit

import Alamofire
import SVProgressHUD

class SearchViewController:BaseViewController {
    
    let webClient = WebClientSearch.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.initTabBar()
        //
        let add = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(addButtonPressed))
        //navigationItem.rightBarButtonItems = [add]
        navigationItem.rightBarButtonItem = add
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addButtonPressed(){
        print("addButtonPressed")
        self.searchRequest()
    }
    
    //MARK: SEARCH REQUEST
    func searchRequest(){
        //https://en.mediawiki.org/w/api.php?action=query&list=search&srsearch=Nelson%20Mandela&format=json
        let webClient = WebClientSearch.shared
        webClient.action = "query"
        webClient.list = "search"
        webClient.srsearch = "Nelson%20Mandela"
        webClient.format = "json"
        
        let params:Parameters = WebClientSearch.shared.getParam()
        //print("params:\n\(params)")
        let url = URL(string: WebClient.api_search)!
        //print("url:\n\(url)")
        let urlString = self.getURL(url:WebClient.api_search , params: params)
        print("urlString:\n\(urlString)")
        
        SVProgressHUD.show()
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON() { response in
            SVProgressHUD.dismiss()
            
            let url = response.response?.url?.absoluteString
            //print("login url:::\n",url ?? "")
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print(response.result.error!)
                let msg = response.result.error!.localizedDescription
                self.showAlert(msg: msg)
                return
            }
            
            print("RESPONSE: \(response.result.value!)" as Any)
            
            if response.result.value != nil {
                guard let response = response.result.value! as? [String:Any] else{return}
                let data = response["continue"] as! [String:Any]
                //let searchResult:[String:Any] = data["query"] as! [String:Any]
                
                let searchQuery = response["query"] as! [String:Any]
                let searchArray = searchQuery["search"]
                print("searchArray:\(searchArray)")
                //if searchArray.count == 0  {return}
                
                self.webClient.setSearchList(list:searchArray as! NSArray)
                print("searchList count:\(self.webClient.searchList.count)")
                
                for search in self.webClient.searchList{
                    print("\(search.title)")
                }
                
            }
        }
        //
    }
    
}


