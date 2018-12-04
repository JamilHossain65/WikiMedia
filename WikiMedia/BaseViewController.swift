//
//  ViewController.swift
//  WikiMedia
//
//  Created by Jamil on 3/12/18.
//  Copyright © 2018 Jamil. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Alert
    func showAlert(msg:String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            // perhaps use action.title here
        })
        self.present(alert, animated: true)
    }
    
    func showAlertWithTitle(title:String ,msg:String){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            // perhaps use action.title here
        })
        self.present(alert, animated: true)
    }

    
    //MARK:  URL concate
    func getURL(url:String,params:[String: Any]) -> String{
        
        let keyArray = params.map {
            $0.key
        }
        
        var paramString:String = url
        var index:Int = 0
        for key in keyArray{
            let const = index + 1 == keyArray.count ? "":"&"
            let str = key.appendingFormat("=\(params[key]!)\(const)")
            
            paramString  += str
            index += 1
        }
        
        print("paramString:\n\(paramString)")
        return paramString
    }

}

