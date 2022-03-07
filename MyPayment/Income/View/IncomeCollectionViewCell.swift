//
//  CollectionViewCell.swift
//  MyPayment
//
//  Created by Антон Дубино on 12.12.2021.
//

import UIKit

class IncomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    weak var viewModel: IncomeCollectionViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            image.image = UIImage(named: viewModel.name)
        }
    }
}
