//
//  ConsumptionViewControllerViewModelType.swift
//  MyPayment
//
//  Created by Антон Дубино on 19.12.2021.
//

import Foundation

protocol ConsumptionViewControllerViewModelType {
    
    var selectedIndexPathItem: IndexPath? { get }
    
    var image: String { get }
    
    var consumptionData: ConsumptionPersistance { get }
    var sections: [DataStructure.Section] { get }
    
    var itemDate: Date? { get }
    var itemSeconds: Int { get }
    
    var popUpSumTextFieldText: Dynamic<String> { get }
    var popUpNameTextFieldText: Dynamic<String> { get }
    var nameLabelText: Dynamic<String> { get }
    var sumLabelText: Dynamic<String> { get }
    var imageCellImage: Dynamic<String> { get }
    var dateLabelText: Dynamic<String> { get }
    var miniPopUpNameText: Dynamic<String> { get }
    var miniPopUpSumText: Dynamic<String> { get }
    var miniPopUpImageViewText: Dynamic<String> { get }
    var miniPopUpDateText: Dynamic<String> { get }
    var datePickerDate: Dynamic<Date> { get }
    var visualEffectHidden: Dynamic<Bool> { get }
    var popUpSaveButtonHidden: Dynamic<Bool> { get }
    var popUpChangeButtonHidden: Dynamic<Bool> { get }
    var popUpSaveButtonEnabled: Dynamic<Bool> { get }
    var popUpChangeButtonEnabled: Dynamic<Bool> { get }
    
    func createImages()
    func popUpSave()
    func popUpCancel()
    func miniPopUpCancel()
    func miniPopUpDelete()
    func miniPopUpChange()
    func sortedArrayByMonth()
    func findSum()
    func addButton()
    
    func tableViewNumberOfSections() -> Int
    func tableViewnumberOfRowsInSection(_ section: Int) -> Int
    func tableViewTitleForHeaderInSection(_ section: Int) -> String?
    func tableViewTitleForFooterInSection(_ section: Int) -> String?
    func tableViewDidSelectRowAt(_ indexPath: IndexPath)
    
    func collectionViewNumberOfItemsInSection() -> Int
    func collectionViewCellForItemAt(_ indexPath: IndexPath) -> ConsumptionCollectionViewCellViewModelType?
    func collectionViewDidSelectItemAt(_ indexPath: IndexPath)
    
    func textFieldShouldChangeCharactersIn(_ string: String)
}
