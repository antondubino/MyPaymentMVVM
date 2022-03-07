//
//  CalculateCollectionViewCell.swift
//  MyPayment
//
//  Created by Антон Дубино on 20.12.2021.
//

import UIKit

class CalculateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    weak var viewModel: CalculateCollectionViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            image.image = UIImage(named: viewModel.name)
        }
    }
}
