//
//  HistoryViewController.swift
//  WikiMedia
//
//  Created by Jamil on 3/12/18.
//  Copyright © 2018 Jamil. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "History"
        self.myTableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.myTableView.reloadData()
    }

    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let height : CGFloat = 100.0
        return height;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let webClient = WebClientSearch.shared
        return webClient.searchList.count
    }
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    //    {
    //        let view : UIView = UIView()
    //        view.backgroundColor = UIColor.clear;
    //        return view;
    //    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let webClient = WebClientSearch.shared
        if(webClient.searchList.count == 0){
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellResult", for: indexPath) as? CellResult else {
            fatalError("The dequeued cell is not an instance of CellResult.")
        }
        
        cell.backgroundColor = UIColor.white
        let result = webClient.searchList[indexPath.row]
        cell.titleLabel?.text = result.title
        cell.detailLabel?.text = result.snippet
        cell.detailLabel?.backgroundColor = UIColor.white
        
        cell.cellRightButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("=> Row no. \(indexPath.row) selected ")
//        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReadViewController") as! UIViewController
//        
//        let webClient = WebClientSearch.shared
//        if(webClient.searchList.count == 0){return}
//        let search:Search = webClient.searchList[indexPath.row]
//        
//        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func rightButtonPressed(btn:UIButton){
        print("bookmarkButtonPressed")
        
        let webClient = WebClientSearch.shared
        let search:Search = webClient.searchList[btn.tag]
        let bookmark = Bookmarks.shared
        bookmark.add(search: search)
        
        for search in bookmark.bookmarkList{
            print("\(search.title)")
        }
    }

}
