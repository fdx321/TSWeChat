//
//  TSRegisterViewController.swift
//  TSWeChat
//
//  Created by 方东祥 on 2017/3/6.
//  Copyright © 2017年 Hilen. All rights reserved.
//

import UIKit
import Hyphenate

class TSRegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var headImageView: UIImageView?
    @IBOutlet var userNameText: UITextField?
    @IBOutlet var passwdText: UITextField?
    @IBOutlet var passwdConfirmText: UITextField?
    @IBOutlet var registerButton: UIButton?
    @IBOutlet var errorLabel:UILabel?
    
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
        self.title = "注册"
        
        self.registerButton?.isEnabled = false
        self.registerButton?.backgroundColor = UIColor.buttonDisableColor
        
        //给headImageView注册点击事件
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(TSRegisterViewController.selectHeadImage));
        self.headImageView?.isUserInteractionEnabled = true;
        self.headImageView?.addGestureRecognizer(singleTap);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: 输入框内容变化事件响应
    @IBAction func editingChanged() {
        if (userNameText?.text?.strip().length)! > 0 && (passwdText?.text?.strip().length)! > 0 && (passwdConfirmText?.text?.strip().length)! > 0 {
            self.registerButton?.isEnabled = true
            self.registerButton?.backgroundColor = UIColor.buttonEnableColor
        }else{
            self.registerButton?.isEnabled = false
            self.registerButton?.backgroundColor = UIColor.buttonDisableColor
        }
        
        if passwdText?.text != passwdConfirmText?.text {
            errorLabel?.text = "两次密码不一致"
        }else{
            errorLabel?.text = ""
        }
    }
    
    //MARK: 点击按钮事件响应
    @IBAction func registerButtonTouchUpInside() {
        //输入预校验
        if passwdText?.text != passwdConfirmText?.text {
            errorLabel?.text = "两次密码不一致"
            return
        }else{
            errorLabel?.text = ""
        }
        
        TSProgressHUD.ts_showWithStatus("loading...")
        
        DispatchQueue.global(qos: .default).async {
            //注册账号
            var error = EMClient.shared().register(withUsername: self.userNameText?.text, password: self.passwdText?.text)
            if error == nil {
                //注册成功，直接进行登录操作
                error = EMClient.shared().login(withUsername: self.userNameText?.text, password: self.passwdText?.text)
                if error == nil {
                    EMClient.shared().options.isAutoLogin = true
                    //登录成功，直接跳转至主页面
                    dispatch_async_safely_to_main_queue({() in
                        self.present(self.mainTabBarController, animated: true, completion: nil)
                    })
                }else{
                    dispatch_async_safely_to_main_queue({() in
                        UIAlertController.ts_singleButtonAlertWithTitle("",message:"注册成功，登录失败，请稍后登录",completion:nil)
                    })
                }
            } else {
                dispatch_async_safely_to_main_queue({() in
                    UIAlertController.ts_singleButtonAlertWithTitle("",message:"注册失败，请检查网络或稍后再尝试",completion:nil)
                })
            }
            dispatch_async_safely_to_main_queue({() in
                TSProgressHUD.ts_dismiss()
            })
        }
    }
    
    //MARK：点击头像框事件响应， 显示相册
    @IBAction func selectHeadImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion:nil)
        }
    }
    
    
    //MARK: 相册选择完照片后，设置头像
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : Any]){
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.headImageView?.image = selectedImage
            self.headImageView?.contentMode = .scaleAspectFill
            self.headImageView?.clipsToBounds = true
        }
        
        dismiss(animated: true, completion: nil)
    }
}
