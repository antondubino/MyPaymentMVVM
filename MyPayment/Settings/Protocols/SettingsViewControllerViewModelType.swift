//
//  SettingsViewControllerViewModelType.swift
//  MyPayment
//
//  Created by Антон Дубино on 15.02.2022.
//

import Foundation

protocol SettingsViewControllerViewModeltype {
    
    var visualEffectHidden: Dynamic<Bool> { get }
    var popUpCodeWordText: Dynamic<String> { get }
    var clueWordText: Dynamic<String> { get }
    var switchButtonIsOn: Dynamic<Bool> { get }
    
    func switchActionIsOn()
    func switchActionIsOff()
    func popUpSaveButtonAction()
    func popUpCancelButtonAction()
    func isOn()
}
