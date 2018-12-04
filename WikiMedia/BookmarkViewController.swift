//
//  BookmarkViewController.swift
//  WikiMedia
//
//  Created by Jamil on 3/12/18.
//  Copyright © 2018 Jamil. All rights reserved.
//

import UIKit

class BookmarkViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Bookmark"
        self.view.backgroundColor = UIColor.lightGray
        //remove empty cell
        myTableView.tableFooterView = UIView()
        
        //add right bar button
        let  rightBarButton = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(rightBarButtonPressed))
        //navigationItem.rightBarButtonItems = [rightButton]
        navigationItem.rightBarButtonItem = rightBarButton
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.myTableView.reloadData()
    }
    
    @objc func rightBarButtonPressed(){
        print("rightBarButtonPressed")
        if myTableView.isEditing {
            myTableView.isEditing = false
        }else{
            myTableView.isEditing = true
        }
    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 100.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let webClient = Bookmarks.shared
        return webClient.bookmarkList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
            let webClient = Bookmarks.shared
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellResult", for: indexPath) as? CellResult else {
                fatalError("The dequeued cell is not an instance of CellResult.")
            }
            
            cell.backgroundColor = UIColor.white
            let result = webClient.bookmarkList[indexPath.row]
            cell.titleLabel?.text = result.title
            cell.detailLabel?.numberOfLines = 0
            cell.detailLabel?.text = result.snippet
            cell.detailLabel?.backgroundColor = UIColor.white
            cell.cellRightButton.tag = indexPath.row
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("=> Row no. \(indexPath.row) selected ")
    }
    
    //MARK: TableView Edit
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let bookmark = Bookmarks.shared
            bookmark.deleteAt(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //todo
            
        }
    }
    
    //MARK: TableView Move
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        return .none
//    }
//
//    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let bookmark = Bookmarks.shared
        bookmark.moveFrom(index: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    //MARK: Button Action
    @IBAction func rightButtonPressed(btn:UIButton){
        print("bookmarkButtonPressed")
        
        let bookmark = Bookmarks.shared
        bookmark.deleteAt(index: btn.tag)
        myTableView.reloadData()
    }
}
