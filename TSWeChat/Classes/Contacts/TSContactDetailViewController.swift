//
//  TSContactDetailViewController.swift
//  TSWeChat
//
//  Created by 方东祥 on 2017/3/10.
//  Copyright © 2017年 Hilen. All rights reserved.
//

import UIKit

class TSContactDetailViewController: UIViewController {
    @IBOutlet weak var button: UIButton?
    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详细资料"

        self.button?.layer.cornerRadius = CGFloat(5.0)
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView(frame:  CGRect(x: 0, y: 0, width: UIScreen.ts_width, height: 0.1))
        self.tableView?.ts_registerCellNib(TSKeyValueTableViewCell.self)
        self.tableView?.ts_registerCellNib(TSContactAvatatTableViewCell.self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func addButtonTouchUpInside(){
        self.show(TSACRequestViewController.ts_initFromNib(), sender:nil)
    }
}


extension TSContactDetailViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //---------------------------------------------------------------------------------//
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 2){
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 88
        }else{
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 0 {
            let cell:TSContactAvatatTableViewCell = tableView.ts_dequeueReusableCell(TSContactAvatatTableViewCell.self)
            return cell
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "设置备注和标签"
        } else if indexPath.section == 2 {
            let cell:TSKeyValueTableViewCell = tableView.ts_dequeueReusableCell(TSKeyValueTableViewCell.self)
            if indexPath.row == 0{
                cell.keyLabel?.text = "地区"
                cell.valueLabel?.text="中国"
            }else{
                cell.keyLabel?.text = "个性签名"
                cell.valueLabel?.text="和我一起敲个微信"
            }
            return cell
        }
        return cell
    }
}
