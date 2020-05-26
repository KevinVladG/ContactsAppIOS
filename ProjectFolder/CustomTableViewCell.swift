//
//  CustomTableViewCell.swift
//  InClass09
//
//  Created by Kevin Granados on 4/4/20.
//  Copyright © 2020 Kevin Granados. All rights reserved.
//

import UIKit

protocol customTVCellDelegate {
    func deleteBTNClicked(cell: UITableViewCell)
}

class CustomTableViewCell: UITableViewCell {

    var delegate:customTVCellDelegate?
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellEmailLabel: UILabel!
    @IBOutlet weak var cellPhonenumLabel: UILabel!
    @IBOutlet weak var cellPhonetypeLabel: UILabel!
    @IBOutlet weak var cellDeleteBTN: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteContactBTN(_ sender: Any) {
        delegate?.deleteBTNClicked(cell: self)
    }
    
    
}
