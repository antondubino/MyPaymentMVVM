//
//  CalculateCollectionViewCellViewModel.swift
//  MyPayment
//
//  Created by Антон Дубино on 20.12.2021.
//

import Foundation

class CalculateCollectionViewCellViewModel: CalculateCollectionViewCellViewModelType {
    
    private var image: Image
    
    var name: String {
        return image.name
    }
    
    init(image: Image) {
        self.image = image
    }
}
