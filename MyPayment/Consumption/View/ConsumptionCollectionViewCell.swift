//
//  ConsumptionCollectionViewCell.swift
//  MyPayment
//
//  Created by Антон Дубино on 19.12.2021.
//

import UIKit

class ConsumptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!

    weak var viewModel: ConsumptionCollectionViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            image.image = UIImage(named: viewModel.name)
        }
    }
    
}
