//
//  BookReadVC.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/12.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit

class BookReadVC: UIViewController , ReadViewDelegate {
    var readVC : BaseReadViewController!
    var readTitle : NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       readVC  = BaseReadViewController()
        
        readVC.delegate = self
        
        view.insertSubview(readVC.view, at: 0)
        
        addChildViewController(readVC)
        let vc = ReadPageVC()
        vc.view.backgroundColor=UIColor.red
        readVC.setController(controller: vc, animated: false, isAbove: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAboveController(coverController: BaseReadViewController?, currentController: UIViewController?) -> UIViewController! {
        let vc = ReadPageVC()
        vc.view.backgroundColor = UIColor.yellow
        return vc
    }
    
    
    func getBelowController(coverController: BaseReadViewController?, currentController: UIViewController?) -> UIViewController! {
        let vc = ReadPageVC()
        vc.view.backgroundColor = UIColor.blue
        return vc
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
