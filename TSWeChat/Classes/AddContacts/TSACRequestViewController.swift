//
//  TSACRequestViewController.swift
//  TSWeChat
//
//  Created by 方东祥 on 2017/3/11.
//  Copyright © 2017年 Hilen. All rights reserved.
//

import UIKit

class TSACRequestViewController: UIViewController {
    @IBOutlet var listTableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "验证申请"
        
        let sendRequestItem = UIBarButtonItem()
        sendRequestItem.title = "发送"
        sendRequestItem.tintColor = UIColor.buttonEnableColor
        self.navigationItem.setRightBarButton(sendRequestItem, animated: true)
        
        self.listTableView?.tableFooterView = UIView(frame:  CGRect(x: 0, y: 0, width: UIScreen.ts_width, height: 0.1))
        self.listTableView?.ts_registerCellNib(TSACRequestCell_1.self)
        
        self.listTableView?.dataSource = self
        self.listTableView?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

extension TSACRequestViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 15
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
     return 0;
     }
     
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
     return 10
     }
     
     func numberOfSections(in tableView: UITableView) -> Int {
     return 3
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 1
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 60
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell:TSSearchTableViewCell = tableView.ts_dequeueReusableCell(TSSearchTableViewCell.self)
     return cell
     }*/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TSACRequestCell_1 = tableView.ts_dequeueReusableCell(TSACRequestCell_1.self)
        cell.titleLabel?.text="你需要发送验证申请，等对方通过"
        return cell
        
    }
}


class TSACRequestCell_1: UITableViewCell {
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var textField: UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


