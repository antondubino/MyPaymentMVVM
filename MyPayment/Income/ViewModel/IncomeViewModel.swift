//
//  IncomeViewModel.swift
//  MyPayment
//
//  Created by Антон Дубино on 10.12.2021.
//

import Foundation

class IncomeViewModel: IncomeViewControllerViewModelType {
    
    private var selectedIndexPathRow: IndexPath?
    var selectedIndexPathItem: IndexPath?
    
    var sectionItems = [DataStructure.SectionItem]()
    var sections = [DataStructure.Section]()
    
    var incomeData = IncomePersistance.shared
    var reportData = ReportPersistance.shared
    
    var itemDate: Date?
    var itemSeconds = 0
    
    let emoji = Emoji.allEmoji
    var images: [Image] = []
    var image = "none"
    
    var amtCost: Int = 0
    var amtDate: Int = 0
    var totalT: Int = 0
    var dateT: Int = 0
    var amountCost: String? = ""
    var amountDate: String? = ""
    
    var sum = 0
    var stringSum: String?
    var report: [String : String] = [:]
  
    var popUpSumTextFieldText = Dynamic("")
    var popUpNameTextFieldText = Dynamic("")
    
    var nameLabelText = Dynamic("")
    var sumLabelText = Dynamic("")
    var imageCellImage = Dynamic("")
    var dateLabelText = Dynamic("")
    var datePickerDate: Dynamic<Date> = Dynamic(Date.now)
    
    var miniPopUpNameText = Dynamic("")
    var miniPopUpSumText = Dynamic("")
    var miniPopUpImageViewText = Dynamic("")
    var miniPopUpDateText = Dynamic("")
    
    var visualEffectHidden = Dynamic(true)
    var popUpSaveButtonHidden = Dynamic(true)
    var popUpChangeButtonHidden = Dynamic(false)
    var popUpSaveButtonEnabled = Dynamic(false)
    var popUpChangeButtonEnabled = Dynamic(false)
    
    var isOn = true
    
//MARK: Add image in images
    
    func createImages() {
        for i in emoji {
            let image = Image(name: i)
            images.append(image)
        }
    }
    
//MARK: Remove collectionView Index
    
    func removeIndex() {
        if selectedIndexPathItem?.count != 0 {
        selectedIndexPathItem?.removeLast()
        image = "none"
        }
    }
    
//MARK: Button actions
    
    func addButton() {
        visualEffectHidden.value = false
        popUpSaveButtonHidden.value = false
        popUpSaveButtonEnabled.value = false
        popUpChangeButtonHidden.value = true
    }
    
// Save from PopUp in Realm
    func popUpSave() {
        visualEffectHidden.value = true
        sum += amtCost
        popUpNameTextFieldText = Dynamic("")
        popUpSumTextFieldText = Dynamic("")
        amtCost = 0
        amtDate = 0
        sortedArrayByMonth()
        findSum()
        removeIndex()
    }
    
    func popUpCancel() {
        visualEffectHidden.value = true
        popUpSaveButtonEnabled.value = false
        popUpNameTextFieldText = Dynamic("")
        popUpSumTextFieldText = Dynamic("")
        amtCost = 0
        amtDate = 0
        removeIndex()
    }
    
    func miniPopUpCancel() {
        visualEffectHidden.value = true
    }
    
    func miniPopUpDelete() {
        for i in incomeData.getItems() {
            if i.date == itemDate && i.date?.seconds == itemSeconds {
                incomeData.remove(item: i)
                sortedArrayByMonth()
            }
        }
        findSum()
        visualEffectHidden.value = true
    }
    
    func miniPopUpChange() {
        for i in incomeData.getItems() {
            if i.date == itemDate && i.date?.seconds == itemSeconds {
                popUpNameTextFieldText.value = i.name
                popUpSumTextFieldText.value = i.sum
                datePickerDate.value = i.date ?? .now
            }
        }
        findSum()
        removeIndex()
        popUpSaveButtonHidden.value = true
        popUpChangeButtonHidden.value = false
    }

//MARK: Sorting array from Realm by month
    
    func updateSum(sum: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: sum))
    }
    
    func findSum() {
        reportData.removeAllIncome()
        report = [:]
        var amount = 0
            for s in sections {
                amount = 0
                for i in s.items {
                    for g in incomeData.getItems() {
                        if g.date == i.date && g.date?.seconds == i.date.seconds {
                            let newSum = g.sum.removingWhitespacesAndNewlines
                            amount += (newSum as NSString).integerValue
                        }
                    }
                }
                let stringSum = updateSum(sum: amount)
                self.stringSum = stringSum
                report[s.title] = stringSum!
    }
        for (t, s) in report {
            let item = ReportIncomeData()
            item.incomeDate = t
            item.incomeSum = s
            reportData.saveIncome(item: item)
        }
}
    
    func sortedArrayByMonth() {
        for i in incomeData.getItems() {
            let dateRecord = DataStructure.SectionItem(date: i.date!)
            sectionItems.append(dateRecord)
        }
        sectionItems.sort()
        sections = []
        var year = 0
        var month = 0
        var section: DataStructure.Section!
        for item in sectionItems {
            if section == nil || item.year != year || item.month != month {
                section = DataStructure.Section(date: item.date)
                sections.append(section)
            }
            section.addRecord(item)
            year = item.year
            month = item.month
        }
        sectionItems = []
    }
    
//MARK: Formatted amount for popUpSumTextField and popUpDateTextField
    
    func updateAmountCost() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amtCost))
    }
    
    func amountCostPlus(str: String) {
        if let digit = Int(str) {
            amtCost = amtCost * 10 + digit
            popUpSumTextFieldText = Dynamic(updateAmountCost() ?? "")
            amountCost = updateAmountCost()
            let text = amountCost!.removingWhitespacesAndNewlines
            let total = (text as NSString).integerValue
            totalT = total
        }
    }
    
    func amountCostMinus(str: String) {
        if str == "" {
            amtCost = amtCost / 10
            popUpSumTextFieldText = Dynamic((amtCost == 0 ? "" : updateAmountCost()) ?? "")
            amountCost = updateAmountCost()
            let text = amountCost!.removingWhitespacesAndNewlines
            let total = (text as NSString).integerValue
            totalT = total
        }
    }
    
//MARK: UITableViewDelegate
    
    func tableViewNumberOfSections() -> Int {
        return sections.count
    }
    
    func tableViewnumberOfRowsInSection(_ section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableViewTitleForHeaderInSection(_ section: Int) -> String? {
        return sections[section].title
    }
    
    func tableViewTitleForFooterInSection(_ section: Int) -> String? {
        var amount = 0
        let itemSection = sections[section]
        for i in itemSection.items{
            for g in incomeData.getItems() {
                if g.date == i.date && g.date?.seconds == i.date.seconds {
                    let newSum = g.sum.removingWhitespacesAndNewlines
                    amount += (newSum as NSString).integerValue
                }
            }
        }
        let sum = updateSum(sum: amount)
        return "Совокупный доход - \(sum!)                                 "
    }
    
    func tableViewDidSelectRowAt(_ indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.row]
        for i in incomeData.getItems() {
            if i.date == item.date && i.date?.seconds == item.date.seconds {
                miniPopUpNameText.value = i.name
                miniPopUpSumText.value = i.sum
                miniPopUpImageViewText.value = i.image
                miniPopUpDateText.value = sections[indexPath.section].items[indexPath.row].title
                itemDate = item.date
                itemSeconds = item.date.seconds
            }
        }
    }
    
//MARK: UICollectionViewDelegate
    
    func collectionViewNumberOfItemsInSection() -> Int {
        return images.count
    }
    
    func collectionViewCellForItemAt(_ indexPath: IndexPath) -> IncomeCollectionViewCellViewModelType? {
        let image = images[indexPath.row]
        return IncomeCollectionViewCellViewModel(image: image)
    }
    
    func collectionViewDidSelectItemAt(_ indexPath: IndexPath) {
        self.selectedIndexPathItem = indexPath
        image = images[indexPath.row].name
    }
    
//MARK: UITextFieldDelegate
    
    func textFieldShouldChangeCharactersIn(_ string: String){
        amountCostPlus(str: string)
        amountCostMinus(str: string)
        if popUpSumTextFieldText.value.count == 13 {
            popUpSumTextFieldText = Dynamic("99 999 999 ₽")
            amtCost = 99999999
            amountCost = "99999999"
        }
    }
}

