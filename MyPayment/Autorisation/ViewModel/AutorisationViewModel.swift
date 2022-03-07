//
//  AutorisationViewModel.swift
//  MyPayment
//
//  Created by Антон Дубино on 12.02.2022.
//

import Foundation
import Locksmith

class AutorisationViewModel: AutorisationViewControllerViewModelType {
    
    var colorView = ""
    var dictionary = Locksmith.loadDataForUserAccount(userAccount: "MyAccount")
    
    var visualEffectViewHidden = Dynamic(true)
    var forgotButtonEnabled = Dynamic(true)
    var labelText = Dynamic("Введите код доступа")
    var popUpClueWordText = Dynamic("")
    var popUpLabelText = Dynamic("Ваш пароль")
    var popUpTextFieldHidden = Dynamic(false)
    var popUpClueLabelHidden = Dynamic(false)
    var popUpShowButtonHidden = Dynamic(false)
    var popUpTextFieldText = Dynamic("")
    var popUpClueLabelText = Dynamic("Подсказка")
   
//MARK: Change text in label
    
    func changeLabelText() {
        visualEffectViewHidden.value = true
        if dictionary == nil {
            forgotButtonEnabled.value = false
            labelText.value = "Придумайте код доступа"
        }
    }
    
//MARK: Button actions
    
    func oneAction() {
        colorView += "1"
    }
    func twoAction() {
        colorView += "2"
    }
    func threeAction() {
        colorView += "3"
    }
    func fourAction() {
        colorView += "4"
    }
    func fiveAction() {
        colorView += "5"
    }
    func sixAction() {
        colorView += "6"
    }
    func sevenAction() {
        colorView += "7"
    }
    func eightAction() {
        colorView += "8"
    }
    func nineAction() {
        colorView += "9"
    }
    func zeroAction() {
        colorView += "0"
    }
    
    func forgotButton() {
        visualEffectViewHidden.value = false
        popUpClueWordText.value = UserDefaults.standard.string(forKey: "ClueWord") ?? ""
    }
 
//MARK: PopUp button actions
    
    func popUpShow() {
            popUpLabelText.value = "Ваш пароль"
            popUpTextFieldHidden.value = true
            popUpClueWordText.value = (dictionary?.first?.value as! String)
            popUpClueLabelHidden.value = true
            popUpShowButtonHidden.value = true
    }
    
    func popUpCancel() {
        visualEffectViewHidden.value = true
        popUpLabelText.value = "Введите кодовое слово"
        popUpTextFieldText.value = ""
        popUpTextFieldHidden.value = false
        popUpClueLabelText.value = "Подсказка"
        popUpClueLabelHidden.value = false
        popUpShowButtonHidden.value = false
    }
}
