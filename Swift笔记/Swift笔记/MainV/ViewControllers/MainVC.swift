//
//  MainVC.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/10.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit
import SnapKit
class MainVC: UIViewController , UITableViewDelegate , UIGestureRecognizerDelegate,UITableViewDataSource {
    let tableview = UITableView(frame: CGRect.zero, style: .plain)
    var listArr : Array<mainBookListModel>? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "书架"
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        tableview.delegate=self
        tableview.dataSource=self
        
        tableview.register(mainBookListCell.self, forCellReuseIdentifier: "booklist")
        
        
        let path = Bundle.main.path(forResource: "BOOKARR", ofType: "plist")
        let listData = NSArray.init(contentsOfFile: path!)
        
        listArr = mainBookListModel.parseWithArr(arr: (listData as! Array<Any> ))
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listArr?.count)!
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "booklist", for: indexPath) as! mainBookListCell
        cell.model = listArr?[indexPath.row].title
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let bookreadvc = BookReadVC()
        bookreadvc.hidesBottomBarWhenPushed = true
        bookreadvc.readTitle = listArr?[indexPath.row]
        self.navigationController?.pushViewController(bookreadvc, animated: true)
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
