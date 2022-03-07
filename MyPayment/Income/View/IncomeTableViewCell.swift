//
//  IncomeTableViewCell.swift
//  MyPayment
//
//  Created by Антон Дубино on 10.12.2021.
//

import UIKit

class IncomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.superview?.backgroundColor = UIColor(red: 249, green: 249, blue: 249, alpha: 0)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        contentView.layer.cornerRadius = 10
    }
    
}
