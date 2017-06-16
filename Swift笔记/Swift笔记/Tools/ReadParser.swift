//
//  ReadParser.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/16.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit
// MARK: -- 四周间距
let HJReadViewTopSpace:CGFloat = 40
let HJReadViewBottomSpace:CGFloat = 40
let HJReadViewLeftSpace:CGFloat = 20
let HJReadViewRightSpace:CGFloat = 20
let HJReadTextViewSpaceWH:CGFloat = 8
class ReadParser: NSObject {
    /**
     获取阅读view的Frame
     
     - returns: frame
     */
    class func GetReadViewFrame() ->CGRect {
        
        return CGRect(x: HJReadViewLeftSpace, y: HJReadViewTopSpace, width: ScreenWidth - HJReadViewLeftSpace - HJReadViewRightSpace, height: ScreenHeight - HJReadViewTopSpace - HJReadViewBottomSpace)
    }
    
    
    

}
