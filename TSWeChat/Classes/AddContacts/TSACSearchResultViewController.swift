//
//  TSACSearchResultViewController.swift
//  TSWeChat
//
//  Created by 方东祥 on 2017/3/10.
//  Copyright © 2017年 Hilen. All rights reserved.
//

import UIKit

class TSACSearchResultViewController: UIViewController {
    @IBOutlet var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.tableFooterView = UIView()
        self.tableView?.ts_registerCellNib(TSACSearchContactCell.self)
        self.tableView?.ts_registerCellNib(TSSearchTableViewCell.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: 搜索框中内容为空的时候结果table view
class TSACBeforeSearch: NSObject,UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

//MARK: 搜索框中内容不为空的时候结果table view
class TSACReadyForSearch: NSObject,UITableViewDelegate,UITableViewDataSource {
    var _searchText: String?
    var searchText: String {
        get{
            return self._searchText!
        }
        set{
            self._searchText = newValue
        }
    }
    
    var _parentViewController: UIViewController?
    var parentViewController: UIViewController {
        get{
            return self._parentViewController!
        }
        set{
            self._parentViewController = newValue
        }
    }
    
    let noResultDelegate = TSACSearchNoResult()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //TODO 要做真实的搜索
        if self.searchText == "123" {
            self.parentViewController.dismiss(animated: false, completion: nil)
            let contactDetailVC = TSContactDetailViewController.ts_initFromNib()
            self.parentViewController.show(contactDetailVC, sender: nil)
        } else {
            noResultDelegate.searchText = self.searchText
            tableView.delegate = noResultDelegate
            tableView.dataSource = noResultDelegate
            tableView.reloadData()
        }
        
    }
    
    
    //---------------------------------------------------------------------------------//
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TSACSearchContactCell = tableView.ts_dequeueReusableCell(TSACSearchContactCell.self)
        cell.searchKeyLabel?.text = self.searchText
        return cell
    }
}


//MARK: 搜索结果为空的时候显示的table view
class TSACSearchNoResult: NSObject,UITableViewDelegate,UITableViewDataSource {
    var _searchText: String?
    var searchText: String {
        get{
            return self._searchText!
        }
        set{
            self._searchText = newValue
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        if section == 0 {
            return 15
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //---------------------------------------------------------------------------------//
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }else{
            return 60
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "该用户不存在"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont.systemFont(ofSize: CGFloat(12.0), weight: CGFloat(0))
            cell.textLabel?.textColor = UIColor.darkGray
            
            return cell
        }else{
            let cell:TSSearchTableViewCell = tableView.ts_dequeueReusableCell(TSSearchTableViewCell.self)
            cell.searchKeyLabel?.text = self.searchText
            return cell
        }
    }
}

