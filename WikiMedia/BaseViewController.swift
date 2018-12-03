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
    
    // MARK: init Tab bar
    func initTabBar(){
        self.initTabBarWith(selectedIndex: 0)
    }
    
    func initTabBarWith(selectedIndex:Int){
        
//        let menu_badges = UIImage(named: "menu_search")
//        let menu_home = UIImage(named: "menu_search")
//        let menu_profile = UIImage(named: "menu_search")
//        let menu_search = UIImage(named: "menu_search")
//        let menu_submit_bar = UIImage(named: "menu_search")
        
        let viewController1:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as UIViewController
        let viewController2:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryViewController") as UIViewController
        let viewController3:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookmarkViewController") as UIViewController
        let viewController4:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookmarkViewController") as UIViewController
        
        let nav1 = UINavigationController(rootViewController: viewController1)
        let nav2 = UINavigationController(rootViewController: viewController2)
        let nav3 = UINavigationController(rootViewController: viewController3)
        let nav4 = UINavigationController(rootViewController: viewController4)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nav1,nav2,nav3,nav4]
        tabBarController.selectedIndex = selectedIndex
        
        //adding all three views to the TabBarView
        let item1 = UITabBarItem(title: "Jamil", image: nil, tag: 0)
        let item2 = UITabBarItem(title: "hossain", image: nil, tag: 1)
        let item3 = UITabBarItem(title: "Banla", image: nil, tag: 2)
        let item4 = UITabBarItem(title: "goge", image: nil, tag: 3)
        
        viewController1.tabBarItem = item1
        viewController2.tabBarItem = item2
        viewController3.tabBarItem = item3
        viewController4.tabBarItem = item4
        self.navigationController?.pushViewController(tabBarController, animated: false)
    }
    
    //refresh notification
    @objc func refreshTabBar(hasNotification:Bool){
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            
            //
            
            if #available(iOS 10.0, *) {
                //tabItem.badgeColor = UIColor.init(patternImage: UIImage(named: "Points.png")!)
            }
            
            if hasNotification == true{
                tabItem.badgeValue = ""
            }else{
                tabItem.badgeValue = nil
            }
            
        }
    }
    
    //refresh tab bar
    @objc func refreshTabBarWith(selectedIndex:Int){
        tabBarController?.selectedIndex = 2
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

