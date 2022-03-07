//
//  SettingsViewModel.swift
//  MyPayment
//
//  Created by Антон Дубино on 15.02.2022.
//

import Foundation
import Locksmith

class SettingsViewModel: SettingsViewControllerViewModeltype {
    
    var visualEffectHidden = Dynamic(true)
    var popUpCodeWordText = Dynamic("")
    var clueWordText = Dynamic("")
    var switchButtonIsOn = Dynamic(false)
 
//MARK: Switch button action
    
    func switchActionIsOn() {
        visualEffectHidden.value = false
    }
    
    func switchActionIsOff() {
        visualEffectHidden.value = true
        do {
        try Locksmith.deleteDataForUserAccount(userAccount: "MyAccount")
        } catch {
            print("error")
        }
        UserDefaults.standard.set(false, forKey: "SwitchOn")
        UserDefaults.standard.set(false, forKey: "FaceIDOn")
        UserDefaults.standard.synchronize()
    }
    
    func isOn() {
        visualEffectHidden.value = true
        let switchBool: Bool = UserDefaults.standard.bool(forKey: "SwitchOn")
        if switchBool {
            switchButtonIsOn.value = true
        }else{
            switchButtonIsOn.value = false
        }
    }
 
//MARK: PopUp button actions
    
    func popUpSaveButtonAction() {
        visualEffectHidden.value = true
        UserDefaults.standard.set(true, forKey: "SwitchOn")
        UserDefaults.standard.set(popUpCodeWordText.value.lowercased().removingWhitespacesAndNewlines, forKey: "CodeWord")
        UserDefaults.standard.set(clueWordText.value, forKey: "ClueWord")
        UserDefaults.standard.synchronize()
    }
    
    func popUpCancelButtonAction() {
        visualEffectHidden.value = true
        popUpCodeWordText.value = ""
        clueWordText.value = ""
        switchButtonIsOn.value = false
    }
}
