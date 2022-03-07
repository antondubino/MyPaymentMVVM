//
//  ReportCollectionViewCell.swift
//  MyPayment
//
//  Created by Антон Дубино on 26.12.2021.
//

import UIKit

class ReportCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var monthAndYearLabel: UILabel!

    weak var viewModel: ReportCollectionViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            monthAndYearLabel.text = viewModel.name
        }
    }
}
