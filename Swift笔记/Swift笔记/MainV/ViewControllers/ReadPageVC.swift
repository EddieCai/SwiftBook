//
//  ReadPageVC.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/12.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit

class ReadPageVC: UIViewController {
    var readView : ReadView?
    var conText : String? = ""
    var isFirstPage : Bool! = true
    var isLastPage : Bool! = false
    override func viewDidLoad() {
        super.viewDidLoad()
        readView = ReadView()
        readView?.backgroundColor = UIColor.red
        view.addSubview(readView!)
        readView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        })
        readView?.content = conText
        readView?.frameRef = ReadParser.parserRead(conText!, bounds:ReadParser.GetReadViewFrame())
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
