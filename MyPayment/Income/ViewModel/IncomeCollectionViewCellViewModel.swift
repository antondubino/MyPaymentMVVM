//
//  IncomeCollectionViewViewModel.swift
//  MyPayment
//
//  Created by Антон Дубино on 13.12.2021.
//

import Foundation

class IncomeCollectionViewCellViewModel: IncomeCollectionViewCellViewModelType {
    
    private var image: Image
    
    var name: String {
        return image.name
    }
    
    init(image: Image) {
        self.image = image
    }
}
