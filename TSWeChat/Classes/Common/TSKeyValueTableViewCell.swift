//
//  TSKeyValueTableViewCell.swift
//  TSWeChat
//
//  Created by 方东祥 on 2017/3/10.
//  Copyright © 2017年 Hilen. All rights reserved.
//

import UIKit

class TSKeyValueTableViewCell: UITableViewCell {
    @IBOutlet weak var keyLabel:UILabel?
    @IBOutlet weak var valueLabel:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
