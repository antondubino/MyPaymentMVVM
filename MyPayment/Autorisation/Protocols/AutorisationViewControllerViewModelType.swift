//
//  AutorisationViewControllerViewModelType.swift
//  MyPayment
//
//  Created by Антон Дубино on 12.02.2022.
//

import Foundation

protocol AutorisationViewControllerViewModelType {
    
    var colorView: String { get set }
    var dictionary: [String : Any]? { get }
    
    var visualEffectViewHidden: Dynamic<Bool> { get }
    var forgotButtonEnabled: Dynamic<Bool> { get }
    var labelText: Dynamic<String> { get }
    var popUpClueWordText: Dynamic<String> { get }
    var popUpLabelText: Dynamic<String> { get }
    var popUpTextFieldHidden: Dynamic<Bool> { get }
    var popUpClueLabelHidden: Dynamic<Bool> { get }
    var popUpShowButtonHidden: Dynamic<Bool> { get }
    var popUpTextFieldText: Dynamic<String> { get }
    var popUpClueLabelText: Dynamic<String> { get }
    
    func changeLabelText()
    func oneAction()
    func twoAction()
    func threeAction()
    func fourAction()
    func fiveAction()
    func sixAction()
    func sevenAction()
    func eightAction()
    func nineAction()
    func zeroAction()
    func forgotButton()
    
    func popUpShow()
    func popUpCancel()
}
