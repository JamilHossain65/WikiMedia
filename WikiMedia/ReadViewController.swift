//
//  ReadViewController.swift
//  WikiMedia
//
//  Created by NevadaSoft on 3/12/18.
//  Copyright © 2018 Jamil. All rights reserved.
//

import UIKit

class ReadViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var textView:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let webClient = WebClientSearch.shared
        if(webClient.searchList.count == 0){return}
        let search:Search = webClient.searchList[0]
        
        textView.text = search.snippet
        textView.isEditable = false
    }

    // MARK: - UITextView Delegate Methods
    func textViewDidBeginEditing(_ textView: UITextView){
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView){
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        return true
    }
    
  
}
