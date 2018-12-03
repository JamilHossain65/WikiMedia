//
//  CellEmpty.swift
//  CraftBeer
//
//  Created by Humayun Kabir on 3/21/18.
//  Copyright © 2018 Humayun Kabir. All rights reserved.
//

import UIKit

class CellEmpty: BaseCell {

    var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear //Utility.getColor(index: Hex.bg_color.rawValue)
        //Left side image
        let border: CGFloat = 10.0
        let x: CGFloat  = 0
        //let y: CGFloat  = 0
        
        let width: CGFloat = UIScreen.main.bounds.size.width
        
        let subviewBG = UIView()
        subviewBG.frame = CGRect(x: border, y: 0, width: width - 2*border, height: 60)
        subviewBG.backgroundColor = UIColor.clear //Utility.getColor(index: Hex.white.rawValue)
        self.addSubview(subviewBG)
        
        //title label
        titleLabel = UILabel()
        titleLabel.text = "Demo Text"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = Utility.defaultFont()
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.frame = CGRect(x:x  , y: 0, width:width - 2*border , height: 60)
        titleLabel.adjustsFontSizeToFitWidth = true
        subviewBG.addSubview(titleLabel)
    }
}
