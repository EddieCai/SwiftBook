//
//  mainBookListCell.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/11.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit

class mainBookListCell: UITableViewCell {
    private var bookImageView : UIImageView?
    private var bookTitle : UILabel?
    private var bookAuthor : UILabel?
    private var newContent : UILabel?
    var model : mainBookListModel?{
        didSet {
            if model != nil {
                self.setCellDate(model: model!)
            }
        }
    }
    

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bookImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.size.equalTo(CGSize(width: 55, height: 80))
            make.centerY.equalTo(self.contentView);
        })
        bookImageView?.superview?.layoutIfNeeded()
        bookTitle?.snp.updateConstraints({ (make) in
            if bookImageView?.frame.size.width != 0{
                make.left.equalTo(bookImageView!.snp.right).offset(10)
            }
            else
            {
                make.left.equalTo(bookImageView!.snp.right).offset(0)
            }
            
            make.top.equalTo(10)
        })
        
        bookAuthor?.snp.makeConstraints({ (make) in
            make.left.equalTo(bookTitle!)
            make.centerY.equalTo(self.contentView)
        })
        
        newContent?.snp.makeConstraints({ (make) in
            make.left.equalTo(bookTitle!)
            make.bottom.equalTo(-20)
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK: 自定义方法
    func initViews() {
        bookImageView = UIImageView.init(image: UIImage.init(named: "daomu1"))
        bookTitle = UILabel()
        bookTitle?.text = "盗墓笔记1"
        bookTitle?.font = UIFont.boldSystemFont(ofSize: 14)
        
        bookAuthor = UILabel()
        bookAuthor?.text = "南派三叔"
        bookAuthor?.font = UIFont.systemFont(ofSize: 12)
        bookAuthor?.textColor = UIColor.red
        
        newContent = UILabel()
        newContent?.text = "更新 : 土豆大结局感言"
        newContent?.font = UIFont.systemFont(ofSize: 12)
        newContent?.textColor = UIColor.gray
        
        
        
        
        self.contentView.addSubview(bookImageView!)
        self.contentView.addSubview(bookTitle!)
        self.contentView.addSubview(bookAuthor!)
        self.contentView.addSubview(newContent!)
    }
    
    func setCellDate(model : mainBookListModel) {
        bookTitle?.text = model.title
        bookAuthor?.text =  model.author
        bookImageView?.image=UIImage.init(named: model.img!)
        newContent?.text = model.time
        
        
    }
    
    
}
