//
//  Bookmarks.swift
//  WikiMedia
//
//  Created by NevadaSoft on 4/12/18.
//  Copyright © 2018 Jamil. All rights reserved.
//

import UIKit

class Bookmarks: NSObject {
    private override init() { }
    public static let shared = Bookmarks()
    
    var bookmarkList:[Search] = []
    
    func empty(){
        bookmarkList.removeAll()
    }
    
    func add(search:Search){
        bookmarkList.append(search)
    }
    
    func deleteAt(index:Int){
        if bookmarkList.count > 0 && bookmarkList.count > index{
            bookmarkList.remove(at: index)
        }
    }
    
    func moveFrom(index:Int,toIndex:Int){
        
        if bookmarkList.count > 0 && bookmarkList.count > index{
            let search = bookmarkList[index]
            bookmarkList.remove(at: index)
            bookmarkList.insert(search, at: toIndex)
        }
    }
    
    func exist(search:Search) -> Bool{
        
        for tempSearch in bookmarkList{
            if tempSearch == search{
                return true
            }
        }
        
        return false
    }
    
}
