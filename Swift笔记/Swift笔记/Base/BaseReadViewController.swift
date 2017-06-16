//
//  BaseReadViewController.swift
//  Swift笔记
//
//  Created by Eddie on 2017/5/12.
//  Copyright © 2017年 Eddie. All rights reserved.
//

import UIKit
@objc protocol ReadViewDelegate {
    func getAboveController(coverController : BaseReadViewController? , currentController : UIViewController?) -> UIViewController!
    func getBelowController(coverController : BaseReadViewController? , currentController : UIViewController?) -> UIViewController!
    @objc optional func isFinishChange(coverController : BaseReadViewController? , currentController : UIViewController? , isfinsh : Bool)
}
class BaseReadViewController: UIViewController {
    private var pan : UIPanGestureRecognizer?
    private var tap : UITapGestureRecognizer?
    private(set) var currentController : UIViewController?
    var gestureRecognizerEnabled : Bool?{
        didSet{
            self.pan?.isEnabled = gestureRecognizerEnabled!;
            self.tap?.isEnabled = true;
        }
    }
    var isPanBegin : Bool? = false
    var isLeft : Bool? = false
    var ispan : Bool? = false
    var isAnimateChange : Bool? = false
    var openAnimate : Bool? = true
    var tempController : UIViewController?
    weak var delegate: ReadViewDelegate?
    var viewWidth : CGFloat {
        get {
            return self.view.frame.width

        }
    }
    var viewHeight : CGFloat {
        get {
            return self.view.frame.height
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.didinit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.isTranslucent = true
    }

    
    deinit {
        //dealloc
    }

    //MARK:Init
    private func didinit(){
        pan = UIPanGestureRecognizer.init(target: self, action: #selector(touchPan(pan:)))
        tap = UITapGestureRecognizer.init(target: self, action: #selector(touchtap(tap:)))
        view.addGestureRecognizer(pan!)
        view.addGestureRecognizer(tap!)
        
        // 启用手势
        self.gestureRecognizerEnabled = true;
        
        // 开启裁剪
        self.view.layer.masksToBounds = true;
    }
    
    
    //MARK:Method

    @objc private func touchPan(pan : UIPanGestureRecognizer){
        let temppoint = pan.translation(in: self.view)
        let touchpoint = pan.location(in: self.view)
        if pan.state == .began{
            if isAnimateChange! {
                return
            }else{
                self.isAnimateChange = true;
                
                self.isPanBegin = true;
                
                self.ispan = true;
            }
        }
        else if pan.state == .changed
        {
            if fabs(temppoint.x) > 0.01 {
                if isPanBegin! {
                   isPanBegin = false
                    // 获取将要显示的控制器
                    self.tempController = GetPanController(touchpoint: temppoint)
                    // 添加
                    addController(controller: tempController)
                    
                }
                
                if openAnimate! && ispan! {
                    if tempController != nil {
                        if isLeft! {
                          tempController?.view.frame  = CGRect(x:touchpoint.x-viewWidth , y: 0, width: viewWidth, height: viewHeight)
                        }
                        else{
                            currentController?.view.frame = CGRect(x:(temppoint.x > 0 ? 0 : temppoint.x) , y: 0, width: viewWidth, height: viewHeight)
                        }
                    }
                }
                
            }
            
        }
        else{ //结束
            if ispan! {
            self.ispan = false
                if openAnimate! {
                    if tempController != nil {
                        var isSuccess = true
                        
                        if isLeft! {
                            if (self.tempController?.view.frame.origin.x)! <= -(viewWidth - viewWidth*CGFloat(0.18)) {
                                isSuccess = false
                            }
                        }
                        else
                        {
                            
                            if (self.currentController?.view.frame.origin.x)! >= CGFloat(-1) {
                                
                                isSuccess = false;
                            }

                        }
                        
                        
                        self.GestureSuccess(isSuccess: isSuccess, animated: true)
                        
                    }
                }
                else
                {
                    isAnimateChange = false
                }
            
                
            }
            else{
                self.GestureSuccess(isSuccess: true, animated: openAnimate!)
            }
            
        }
        
        
    }
    
    @objc private func touchtap(tap : UIPanGestureRecognizer){
        
    }
    
    
    private func GetPanController(touchpoint : CGPoint) -> UIViewController?
    {
        var vc : UIViewController? = nil
        
        if touchpoint.x > 0 {
            isLeft = true
            if delegate != nil {
                vc = delegate?.getAboveController(coverController: self, currentController: currentController)
            }
        }
        else
        {
            isLeft = false
            if delegate != nil {
                vc = delegate?.getBelowController(coverController: self, currentController: currentController)
            }
        }
        if vc  == nil {
            self.isAnimateChange = false

        }
        
        return vc
        
    }
    
    
    
    private func addController(controller : UIViewController?){
        if controller != nil {
            
            if isLeft! {
                self.addChildViewController(controller!)
                view.addSubview((controller?.view)!)
                controller?.view.frame = CGRect(x:-viewWidth , y: 0, width: viewWidth, height: viewHeight)
                
            }
            else
            {
                if currentController != nil{
                    view.insertSubview((controller?.view)!, belowSubview: (currentController?.view)!)
                }
                else{
                    view.addSubview((controller?.view)!)
                    
                }
                controller?.view.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
            }
            
            setShadowController(controller: controller)
        }
        
    
    }
    
    private func setShadowController(controller : UIViewController?){
        controller?.view.layer.shadowColor = UIColor.black.cgColor
        controller?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        controller?.view.layer.shadowOpacity = 0.5
        controller?.view.layer.shadowRadius = 10
    }
    
    func setController(controller : UIViewController! ,animated : Bool , isAbove : Bool) {
        if animated || self.currentController != nil {
            
        }
        else
        {
            
            self.addController(controller: controller)
            
            // 修改frame
            controller.view.frame = self.view.bounds;
            if currentController != nil {
                currentController?.view.removeFromSuperview()
                currentController?.removeFromParentViewController()
            }
            
            // 赋值记录
            currentController = controller;
        }
        
        
        
    }
    
    
    private func animateSuccess(Success : Bool){
        if Success {
            currentController?.view.removeFromSuperview()
            currentController?.removeFromParentViewController()
            currentController = self.tempController
            self.tempController = nil
            self.isAnimateChange = false
        }
        else{
            
            tempController?.view.removeFromSuperview()
            tempController?.removeFromParentViewController()
            self.tempController = nil
            self.isAnimateChange = false
        }
    }
    
    
    private func GestureSuccess(isSuccess : Bool , animated : Bool){
        if tempController != nil {
            if isLeft! {
                if animated {
                    UIView.animate(withDuration: 0.2, animations: { [weak self] in
                        if isSuccess {
                            self?.tempController?.view.frame = CGRect(x: 0, y: 0, width: (self?.viewWidth)!, height: (self?.viewHeight)!)
                        }else
                        {
                            self?.tempController?.view.frame = CGRect(x: -(self?.viewWidth)!, y: 0, width: (self?.viewWidth)!, height: (self?.viewHeight)!)
                        }
                        
                    }, completion: { [weak self] (isf) in
                        self?.animateSuccess(Success: isSuccess)
                    })
                }
                else
                {
                    if isSuccess {
                        tempController?.view.frame = CGRect(x:0 , y: 0, width: viewWidth, height: viewHeight)
                    }
                    else{
                        tempController?.view.frame = CGRect(x:-viewWidth , y: 0, width: viewWidth, height: viewHeight)
                    }
                    animateSuccess(Success: isSuccess)
                }
            }
            else
            {
                if animated {
                    UIView.animate(withDuration: 0.2, animations: { [weak self] in
                        if isSuccess {
                            self?.currentController?.view.frame = CGRect(x: -(self?.viewWidth)!, y: 0, width: (self?.viewWidth)!, height: (self?.viewHeight)!)
                        }else
                        {
                            self?.currentController?.view.frame = CGRect(x: 0, y: 0, width: (self?.viewWidth)!, height: (self?.viewHeight)!)
                        }
                        
                        }, completion: { [weak self] (isf) in
                            self?.animateSuccess(Success: isSuccess)
                    })
                }
                else
                {
                    if isSuccess {
                        currentController?.view.frame = CGRect(x:-viewWidth , y: 0, width: viewWidth, height: viewHeight)
                    }
                    else{
                        currentController?.view.frame = CGRect(x:0 , y: 0, width: viewWidth, height: viewHeight)
                    }
                    animateSuccess(Success: isSuccess)
                }
            }
        }
    }
    
    
}
