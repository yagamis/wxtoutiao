//
//  TextCell.swift
//  WxToutiao
//
//  Created by yons on 2017/5/22.
//  Copyright © 2017年 yons. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
