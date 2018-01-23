//
//  studentTableViewCell.swift
//  OnTheMap
//
//  Created by Farzad on 1/12/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit

class studentTableViewCell: UITableViewCell {

    @IBOutlet weak var studentName: UILabel!
    var studentURL:String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
