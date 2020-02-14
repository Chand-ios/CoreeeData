//
//  AlaramDetailsTableViewCell.swift
//  CoreDataAlarm
//
//  Created by eAlphaMac2 on 14/02/20.
//  Copyright © 2020 eAlphaMac2. All rights reserved.
//

import UIKit

class AlaramDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
