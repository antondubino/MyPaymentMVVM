//
//  CalculateViewControllerViewModelType.swift
//  MyPayment
//
//  Created by Антон Дубино on 20.12.2021.
//

import Foundation

protocol CalculateViewControllerViewModelType {
    
    var selectedIndexPathItem: IndexPath? { get }
    
    var image: String { get }
    
    var totalCostText: Dynamic<String> { get }
    var initialText: Dynamic<String> { get }
    var termText: Dynamic<String> { get }
    var bidText: Dynamic<String> { get }
    var popUpNameTextFieldText: Dynamic<String> { get }
    var yearsButton: Dynamic<Bool> { get }
    var monthsButton: Dynamic<Bool> { get }
    var saveButton: Dynamic<Bool> { get }
    var paymentText: Dynamic<String> { get }
    var creditAmountText: Dynamic<String> { get }
    var creditAmountWithPercentText: Dynamic<String> { get }
    var interestText: Dynamic<String> { get }
    var termPlaceholder: Dynamic<String> { get }
    var initialPlaceholder: Dynamic<String> { get }
    
    var visualEffectHidden: Dynamic<Bool> { get }
    var popUpSaveButtonEnabled: Dynamic<Bool> { get }
    
    var data: ConsumptionPersistance { get }
    
    func saveButtonAction()
    func culcResultYears()
    func popUpSave()
    func popUpCancel()
    func toMonthsAction()
    func toYearsAction()
    func toRoubleAction()
    func toPercentAction()
    
    func createImages()
    func updateAmountTotalCost() -> String?
    func updateAmountInitial() -> String?
    func updateTermYears() -> String?
    func updateBid() -> String?
    func amountTotalCost(string: String)
    func amountInitial(string: String)
    func amountTerm(string: String)
    func amountBid(string: String)
    
    func collectionViewNumberOfItemsInSection() -> Int
    func collectionViewCellForItemAt(_ indexPath: IndexPath) -> CalculateCollectionViewCellViewModelType?
    func collectionViewDidSelectItemAt(_ indexPath: IndexPath)
}
