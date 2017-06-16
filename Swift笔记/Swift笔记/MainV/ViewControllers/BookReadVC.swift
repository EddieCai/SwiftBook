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
    var readTitle : String?
    var readmodel : ReadModel?
    var readpage : Int! = 0
    var chaptersPage : Int! = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       readVC  = BaseReadViewController()
        
        readVC.delegate = self
        view.insertSubview(readVC.view, at: 0)
        
        addChildViewController(readVC)
        let vc = ReadPageVC()
        vc.view.backgroundColor=UIColor.red
        readVC.setController(controller: getFristController(), animated: false, isAbove: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getReadVC() -> UIViewController {
        let vc = ReadPageVC()
        vc.conText = readmodel?.readChapterListModels?[chaptersPage].stringOfPage(readpage)
        return vc
    }
    
    
    func getFristController() -> UIViewController {
        let vc = ReadPageVC()
        let path = Bundle.main.path(forResource: readTitle, ofType: "plist")
        let listData  = NSDictionary.init(contentsOfFile: path!)
        readmodel = ReadModel.parseWithDic(dic: listData)
        vc.conText = readmodel?.readChapterListModels?[chaptersPage].stringOfPage(readpage)
        
        return vc
    }
    
    func getAboveController(coverController: BaseReadViewController?, currentController: UIViewController?) -> UIViewController! {
        if readpage == 0 {
            if chaptersPage == 0  {
                return nil
            }
            else{
                
                chaptersPage! -= 1
                readpage = Int((readmodel?.readChapterListModels?[chaptersPage].pageCount)!) - 1
            }
            
        }
        else{
            readpage! -= 1
        }
        
        return getReadVC()
    }
    
    
    func getBelowController(coverController: BaseReadViewController?, currentController: UIViewController?) -> UIViewController! {
        if readpage == (Int((readmodel?.readChapterListModels?[chaptersPage].pageCount)!) - 1) {
            if chaptersPage == ((readmodel?.readChapterListModels?.count)! - 1)  {
                return nil
            }
            else{
                
                chaptersPage! += 1
                readpage = 0
            }
            
        }
        else{
            readpage! += 1
        }
        
        return getReadVC()
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
