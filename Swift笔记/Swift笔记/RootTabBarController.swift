//
//  RootTabBarController.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/10.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit
class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewControllers();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initViewControllers(){

        self.viewControllers = [initNav(imagestr: "mine", namestr: "书架", vC: MainVC()),initNav(imagestr: "category_gray", namestr: "分类", vC: TwoMainVC()),initNav(imagestr: "search_gray", namestr: "搜索", vC: ThreeMainVC()),initNav(imagestr: "more_gray", namestr: "更多", vC: FourMainVC())]
    
    }

    
    
    private func initNav(imagestr : String , namestr : String , vC : UIViewController) -> UINavigationController
    {
        let image = UIImage.init(named: imagestr)
        vC.tabBarItem = UITabBarItem.init(title: namestr, image: image, selectedImage: nil)
        return  BaseNavigationController.init(rootViewController: vC)
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
