//
//  TSLoginViewController.swift
//  TSWeChat
//
//  Created by 方东祥 on 2017/3/8.
//  Copyright © 2017年 Hilen. All rights reserved.
//

import UIKit
import Hyphenate

class TSLoginViewController: UIViewController {
    @IBOutlet var userNameText: UITextField!
    @IBOutlet var passwdText: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    var _mainTabBarController: UITabBarController?
    var mainTabBarController: UITabBarController {
        get {
            return self._mainTabBarController!
        }
        set {
            self._mainTabBarController = newValue
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        
        self.loginButton?.isEnabled = false
        self.loginButton?.backgroundColor = UIColor.buttonDisableColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: 输入框内容变化事件响应
    @IBAction func editingChanged() {
        if (userNameText?.text?.strip().length)! > 0 && (passwdText?.text?.strip().length)! > 0 {
            self.loginButton?.isEnabled = true
            self.loginButton?.backgroundColor = UIColor.buttonEnableColor
        }else{
            self.loginButton?.isEnabled = false
            self.loginButton?.backgroundColor = UIColor.buttonDisableColor
        }
    }

    //MARK: 点击登录按钮事件响应
    @IBAction func loginButtonTouchUpInside() {
        TSProgressHUD.ts_showWithStatus("loading...")
        DispatchQueue.global(qos: .default).async {
            let error = EMClient.shared().login(withUsername: self.userNameText?.text, password: self.passwdText?.text)
            if error == nil {
                EMClient.shared().options.isAutoLogin = true
                //登录成功，直接跳转至主页面
                dispatch_async_safely_to_main_queue({() in
                    self.present(self.mainTabBarController, animated: true, completion: nil)
                })
            }else{
                dispatch_async_safely_to_main_queue({() in
                    UIAlertController.ts_singleButtonAlertWithTitle("",message:"登录失败，请检查网络或稍后重试",completion:nil)
                })
            }
            
            dispatch_async_safely_to_main_queue({() in
                TSProgressHUD.ts_dismiss()
            })
        }
    }
    
    //MARK: 点击注册按钮事件响应
    @IBAction func registerButtonTouchUpInside() {
        let registerViewController = TSRegisterViewController.ts_initFromNib() as! TSRegisterViewController
        registerViewController.mainTabBarController = self.mainTabBarController
        self.show(registerViewController, sender: nil)
    }
    
}
