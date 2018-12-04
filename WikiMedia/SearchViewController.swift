//
//  SearchBarViewController.swift
//  CraftBeer
//
//  Created by Humayun Kabir on 11/9/18.
//  Copyright © 2018 Humayun Kabir. All rights reserved.
//

import UIKit

import Alamofire
import SVProgressHUD


class SearchViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var currentTextField = UITextField()
    
    let webClient = WebClientSearch.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Search"
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = UIColor.lightGray
        myTableView.separatorStyle = .singleLine
        myTableView.allowsSelection = true

        //remove empty cell
        myTableView.tableFooterView = UIView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @objc func addButtonPressed(){
        print("addButtonPressed")
        self.showAlert(msg: "Under development")
    }
    
    //MARK: SEARCH REQUEST
    func searchRequestWith(text:String){
        //https://en.mediawiki.org/w/api.php?action=query&list=search&srsearch=Nelson%20Mandela&format=json
        let webClient = WebClientSearch.shared
        webClient.action = "query"
        webClient.list = "search"
        webClient.srsearch = text //"Nelson%20Mandela"
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
                
                
                if let error = response["error"] as? [String:Any]{
                    let info = error["info"] as! String
                    self.webClient.setSearchList(list:[])
                    
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
                    
                    self.showAlert(msg: info)
                    
                }else{
                    //let data = response["continue"] as! [String:Any]
                  
                    if let searchQuery = response["query"] as? [String:Any]{
                        if let searchArray = searchQuery["search"]{
                            //print("searchArray:\(searchArray)")
                            
                            self.webClient.setSearchList(list:searchArray as! NSArray)
                            print("searchList count:\(self.webClient.searchList.count)")
                            
                            for search in self.webClient.searchList{
                                print("\(search.title)")
                            }
                            
                            DispatchQueue.main.async {
                                self.myTableView.reloadData()
                            }
                        }
                        
                    }
                   
                }
                
                
            }
        }
        //
    }
    
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var height : CGFloat = 100.0
        
        if(indexPath.section == 0){
            height = 60.0
        }
        
        return height;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let webClient = WebClientSearch.shared
        
        if(section==0){
            return 1
        }
        
        return webClient.searchList.count
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let view : UIView = UIView()
//        view.backgroundColor = UIColor.clear;
//        return view;
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if(indexPath.section == 0){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellSearchBar", for: indexPath) as? CellSearchBar  else {
                fatalError("The dequeued cell is not an instance of CellSearchBar.")
            }
            cell.inputTextField.delegate = self
            cell.searchButton.addTarget(self, action: #selector(self.searchButtonPressed(btn:)), for: UIControlEvents.touchUpInside)
            return cell
            
        }else{
            
            let webClient = WebClientSearch.shared
            if(webClient.searchList.count == 0){
                /*
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellEmpty", for: indexPath) as? CellEmpty  else {
                    fatalError("The dequeued cell is not an instance of CellEmpty.")
                }
                cell.titleLabel.text = "No result found"
                //cell.selectionStyle = UITableViewCellSelectionStyle.none
 */
                return UITableViewCell()
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellResult", for: indexPath) as? CellResult else {
                fatalError("The dequeued cell is not an instance of CellResult.")
            }
            
            cell.backgroundColor = UIColor.white
            let result = webClient.searchList[indexPath.row]
            cell.titleLabel?.text = result.title
            cell.detailLabel?.numberOfLines = 0
            cell.detailLabel?.text = result.snippet
            cell.detailLabel?.backgroundColor = UIColor.white
            
            cell.cellRightButton.tag = indexPath.row
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("=> Row no. \(indexPath.row) selected ")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        /*
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReadViewController") as! UIViewController

        let webClient = WebClientSearch.shared
        if(webClient.searchList.count == 0){return}
        let search:Search = webClient.searchList[indexPath.row]
        
        self.present(viewController, animated: true, completion: nil)
        */
    }
   
    //MARK: - Button Pressed action
    @IBAction func searchButtonPressed(btn:UIButton){
        print("searchButtonPressed")
        currentTextField.resignFirstResponder()
        self.searchRequestWith(text: currentTextField.text!)
    }
    
    @IBAction func rightButtonPressed(btn:UIButton){
        print("bookmarkButtonPressed")
        
        let webClient = WebClientSearch.shared
        let search:Search = webClient.searchList[btn.tag]
        let bookmark = Bookmarks.shared
        
        if(bookmark.exist(search: search)){
            self.showAlert(msg: "Already Bookmarked!")
        }else{
            bookmark.add(search: search)
            for search in bookmark.bookmarkList{
                print("\(search.title)")
            }
            self.showAlertWithTitle(title: "Bookmarked", msg: search.title)
        }
        
    }
    
    //MARK:  TextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        currentTextField = textField
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        //print("TextField Value = \(textField.text ?? "No value")")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        print("TextField text = \(textField.text ?? "No text")")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

