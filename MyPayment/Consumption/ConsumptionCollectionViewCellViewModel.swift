//
//  ConsumptionCollectionViewCellViewModel.swift
//  MyPayment
//
//  Created by Антон Дубино on 19.12.2021.
//

import Foundation

class ConsumptionCollectionViewCellViewModel: ConsumptionCollectionViewCellViewModelType {
    
    private var image: Image
    
    var name: String {
        return image.name
    }
    
    init(image: Image) {
        self.image = image
    }
    
}
