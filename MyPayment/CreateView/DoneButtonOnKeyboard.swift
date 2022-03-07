//
//  DoneButtonOnKeyboard.swift
//  MyPayment
//
//  Created by Антон Дубино on 19.12.2021.
//

import Foundation
import UIKit

protocol CreateButton {
    var view: UIView? { get set }
    func addDoneButtonOnKeyboard() -> UIToolbar
}

class DoneButton: CreateButton {
    var view: UIView?
    
    func addDoneButtonOnKeyboard() -> UIToolbar {
        let toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: view!.frame.size.width, height: 35))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(doneButtonAction))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
    
    @objc func doneButtonAction() {
        view!.endEditing(true)
    }
    
}
