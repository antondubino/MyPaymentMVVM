//
//  SettingsViewController.swift
//  MyPayment
//
//  Created by Антон Дубино on 06.02.2022.
//

import UIKit
import Locksmith

class SettingsViewController: UIViewController {

    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var popUpCodeWord: UITextField!
    @IBOutlet weak var clueWord: UITextField!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var viewModel: SettingsViewControllerViewModeltype? = SettingsViewModel()
    var animatePopUp: AnimatePopUp? = PopUp()
    var doneButton: CreateButton? = DoneButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton?.view = view
        popUpCodeWord.inputAccessoryView = doneButton?.addDoneButtonOnKeyboard()
        clueWord.inputAccessoryView = doneButton?.addDoneButtonOnKeyboard()
        bind()
        viewModel?.isOn()
    }
    
    func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.visualEffectHidden >>> { self.visualEffectView.isHidden = $0 }
        viewModel.popUpCodeWordText >>> { self.popUpCodeWord.text = $0 }
        viewModel.clueWordText >>> { self.clueWord.text = $0 }
        viewModel.switchButtonIsOn >>> { self.switchButton.isOn = $0 }
    }
    
    @IBAction func switchAction(_ sender: Any) {
        if switchButton.isOn {
            viewModel?.switchActionIsOn()
            animatePopUp?.animateInSettings(view: view, popUp: popUpView)
        } else {
            viewModel?.switchActionIsOff()
        }
    }
    
    @IBAction func popUpSaveButtonAction(_ sender: Any) {
        viewModel?.popUpCodeWordText.value = popUpCodeWord.text ?? ""
        viewModel?.clueWordText.value = clueWord.text ?? ""
        if (popUpCodeWord.text != nil) && clueWord.text != nil {
            viewModel?.popUpSaveButtonAction()
        let vc = storyboard?.instantiateViewController(withIdentifier: "Main") as! AutorisationViewController
        vc.modalPresentationStyle = .fullScreen
        animatePopUp?.animateOut(popUp: popUpView)
        self.present(vc, animated: false)
        }
    }
    
    @IBAction func popUpCancelButtonAction(_ sender: Any) {
        viewModel?.popUpCancelButtonAction()
        animatePopUp?.animateOut(popUp: popUpView)
    }
}
