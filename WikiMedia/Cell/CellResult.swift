//
//  CellResult.swift
//  WikiMedia
//
//  Created by NevadaSoft on 3/12/18.
//  Copyright © 2018 Jamil. All rights reserved.
//

import UIKit

class CellResult: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var cellRightButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
