//
//  mainBookListModel.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/11.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit

class mainBookListModel: NSObject {

    var author : String?
    var img : String?
    var time : String?
    var chapterlist : Array<Any>?
    var title : String?
    var href : String?
    var chapterArrArr : Array<Any>?
    var partTitleArr : Array<Any>?
    
    class func parseWithArr(arr : Array<Any>?) -> Array<mainBookListModel>? {
        if arr == nil {
            return []
            
        }
        
      var  listArr : Array<mainBookListModel> = []
        
        for a  in arr! {
            let a = a as! Dictionary<String, Any>
            listArr.append(mainBookListModel.modelFromDic(d: a))
        }
        return listArr
    }
    
    
    
    class func modelFromDic(d : Dictionary<String, Any>) -> mainBookListModel {
        let model = mainBookListModel()
        model.setValuesForKeys(d)
        return model
    }
    override func value(forUndefinedKey key: String) -> Any? {
        return nil
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
