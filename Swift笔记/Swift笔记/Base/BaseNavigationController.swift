//
//  BaseNavigationController.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/12.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController , UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate=self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        || (self.viewControllers.last?.isKind(of: BookReadVC.self))!
        if self.viewControllers.count == 1  {
            return false
        }
        return true
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
