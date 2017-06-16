//
//  ReadView.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/16.
//  Copyright © 2017年 Eddie. All rights reserved.
//
/// 电池宽推荐使用宽高
var HJBatterySize:CGSize = CGSize(width: 25, height: 10)

/// 电池量宽度 跟图片的比例
private var HJBatteryLevelViewW:CGFloat = 20
private var HJBatteryLevelViewScale = HJBatteryLevelViewW / HJBatterySize.width
import UIKit

class ReadView: UIView {


    /// 当前文字
    var content:String!
    
    /// 当前视图文字
    var frameRef:CTFrame? {
        
        didSet{
            
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        
        if (frameRef == nil) {
            
            return
        }
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.textMatrix = CGAffineTransform.identity
        ctx?.translateBy(x: 0, y: bounds.size.height);
        ctx?.scaleBy(x: 1.0, y: -1.0);
        CTFrameDraw(frameRef!, ctx!);
    }

}
