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
    
    
    class func pageRange(string: String,rect:CGRect, attrs: [String : Any]?) ->[Int] {
        
        // 记录
        var pageLocationArray:[Int] = []
        
        // 拼接字符串
        let attrString = NSMutableAttributedString(string: string, attributes: attrs)
        
        let frameSetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedString)
        
        let path = CGPath(rect: rect, transform: nil)
        
        var currentOffset = 0
        
        var currentInnerOffset = 0
        
        var hasMorePages:Bool = true
        
        // 防止死循环，如果在同一个位置获取CTFrame超过2次，则跳出循环
        let preventDeadLoopSign = currentOffset
        
        var samePlaceRepeatCount = 0
        
        while hasMorePages {
            
            if preventDeadLoopSign == currentOffset {
                
                samePlaceRepeatCount += 1
                
            }else{
                
                samePlaceRepeatCount = 0
            }
            
            if samePlaceRepeatCount > 1 {
                
                if pageLocationArray.count == 0 {
                    
                    pageLocationArray.append(currentOffset)
                    
                }else{
                    
                    let lastOffset = pageLocationArray.last
                    
                    if lastOffset != currentOffset {
                        
                        pageLocationArray.append(currentOffset)
                    }
                }
                
                break
            }
            
            pageLocationArray.append(currentOffset)
            
            let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentInnerOffset, 0), path, nil)
            let range = CTFrameGetVisibleStringRange(frame)
            
            if (range.location + range.length) != attrString.length {
                
                currentOffset += range.length
                
                currentInnerOffset += range.length
                
            }else{
                
                // 已经分完，提示跳出循环
                
                hasMorePages = false
            }
        }
        
        return pageLocationArray
    }
    class func parserAttribute() ->[String:AnyObject] {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        paragraphStyle.alignment = NSTextAlignment.justified
        let font = UIFont.systemFont(ofSize: 18)
        let dict = [NSForegroundColorAttributeName:UIColor.black,NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle]
        
        return dict as [String : AnyObject]
    }
    
    
    class func parserRead(_ content:String,bounds:CGRect) ->CTFrame {
        
        let attributedString = NSMutableAttributedString(string: content,attributes: parserAttribute())
        
        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
        
        let path = CGPath(rect: bounds, transform: nil)
        
        let frameRef = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        
        return frameRef
    }

}
