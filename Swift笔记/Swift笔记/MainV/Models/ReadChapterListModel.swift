//
//  readChapterListModel.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/16.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit

class ReadChapterListModel: NSObject {
    var chapterContent : String! = ""
    var chapterTitle : String?
    var pageCount:NSNumber = 0             // 本章有多少页
    var pageLocationArray:[Int] = []       // 分页的起始位置
    
    class func parseWithArr(arr : Array<Any>) -> Array<ReadChapterListModel> {
        let temparr : Array<Dictionary<String, Any>> = arr[0] as! Array<Dictionary<String, Any>>
        var modelarr = Array<ReadChapterListModel>()

        for dic in temparr {
            modelarr.append(getModelFromDic(dic))
        }
        return modelarr
    }
    
    /// 刷新字体
    func updateFont() {
        
        pageLocationArray = ReadParser.pageRange(string: chapterContent, rect: ReadParser.GetReadViewFrame(), attrs: ReadParser.parserAttribute())
        
        pageCount = NSNumber(value:pageLocationArray.count)
    }
    
    
    class func getModelFromDic(_ dic : Dictionary<String, Any>) -> ReadChapterListModel {
        let model = ReadChapterListModel()
        model.chapterContent = (dic["chapterContent"] as! String)
        model.chapterTitle = (dic["chapterTitle"] as! String)
        model.pageLocationArray = ReadParser.pageRange(string: model.chapterContent, rect: ReadParser.GetReadViewFrame(), attrs: ReadParser.parserAttribute())
        model.pageCount = NSNumber(value:model.pageLocationArray.count)
        return model
    }
    
    
    // 获取指定索引的range
    func getRangeWithPage(_ page:Int) ->NSRange {
        
        let local = pageLocationArray[page]
        
        var length = 0
        
        if page < pageCount.intValue - 1 {
            
            length = pageLocationArray[page + 1] - pageLocationArray[page]
            
        }else{
            
            length = chapterContent.length - pageLocationArray[page]
        }
        
        return NSMakeRange(local, length)
    }
    
    /**
     根据index 页码返回对应的字符串
     
     - parameter page: 页码索引
     */
    func stringOfPage(_ page:Int) ->String {
        
        let range = getRangeWithPage(page)
        
        return chapterContent.substringWithRange(range)
    }
}


