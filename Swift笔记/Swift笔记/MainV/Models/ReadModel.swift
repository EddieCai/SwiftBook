//
//  readModel.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/16.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit

class ReadModel: NSObject {
    var readTitle : String?
    var readChapterListModels : Array<ReadChapterListModel>?
    
    class func parseWithDic(dic : NSDictionary?) -> ReadModel {
        let model = ReadModel()
        model.readTitle = (dic?.object(forKey: "title") as! String)
        model.readChapterListModels = ReadChapterListModel.parseWithArr(arr: dic?.object(forKey: "chapterArrArr") as! Array<Any>)
        return model
    }
}
