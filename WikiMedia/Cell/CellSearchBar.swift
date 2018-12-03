//
//  CellSearchBar.swift
//  CraftBeer
//
//  Created by Humayun Kabir on 1/12/18.
//  Copyright © 2018 Humayun Kabir. All rights reserved.
//

import UIKit

class CellSearchBar: UITableViewCell {
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //NotificationCenter.default.addObserver(self, selector: #selector(CellLogin.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        //Take Action on Notification
        inputTextField.resignFirstResponder()
    }
}
