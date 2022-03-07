//
//  AutorisationViewController.swift
//  MyPayment
//
//  Created by Антон Дубино on 01.02.2022.
//

import UIKit
import Locksmith
import LocalAuthentication
import AudioToolbox

class AutorisationViewController: UIViewController {

    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var zerobutton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var faceIDButton: UIButton!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var popUpShowButton: UIButton!
    @IBOutlet weak var popUpLabelText: UILabel!
    @IBOutlet weak var popUpTextField: UITextField!
    @IBOutlet weak var popUpClueWord: UILabel!
    @IBOutlet weak var popUpClueLabel: UILabel!
    
    var viewModel: AutorisationViewControllerViewModelType? = AutorisationViewModel()
    var animatePopUp: AnimatePopUp? = PopUp()
    var doneButton: CreateButton? = DoneButton()
    var dictionary = Locksmith.loadDataForUserAccount(userAccount: "MyAccount")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        doneButton?.view = view
        popUpTextField.inputAccessoryView = doneButton?.addDoneButtonOnKeyboard()
        viewModel?.changeLabelText()
        layers()
        face()
    }
    
//MARK: Binding
    
    func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.visualEffectViewHidden >>> { self.visualEffectView.isHidden = $0 }
        viewModel.forgotButtonEnabled >>> { self.forgotButton.isEnabled = $0 }
        viewModel.labelText >>> { self.labelText.text = $0 }
        viewModel.popUpClueWordText >>> { self.popUpClueWord.text = $0 }
        viewModel.popUpLabelText >>> { self.popUpLabelText.text = $0 }
        viewModel.popUpTextFieldHidden >>> { self.popUpTextField.isHidden = $0 }
        viewModel.popUpClueLabelHidden >>> { self.popUpClueLabel.isHidden = $0 }
        viewModel.popUpShowButtonHidden >>> { self.popUpShowButton.isHidden = $0 }
        viewModel.popUpTextFieldText >>> { self.popUpTextField.text = $0 }
        viewModel.popUpClueLabelText >>> { self.popUpClueLabel.text = $0 }
    }
    
//MARK: Layers
    
    func layers() {
        let objects = [firstView, secondView, thirdView, fourthView]
        for o in objects {
            o?.layer.cornerRadius = 0.5 * (o?.bounds.size.width)!
        }
    }

//MARK: Password
    
    func createPassword() {
        guard let viewModel = viewModel else { return }
        let password = viewModel.colorView
        do {
            try Locksmith.saveData(data: ["Password" : password], forUserAccount: "MyAccount")
            dismiss(animated: false, completion: nil)
        } catch {
            print("Error")
        }
    }
    
    func colorizeView() {
        faceIDButton.setImage(UIImage(systemName: "delete.left"), for: .normal)
        let objects = [firstView, secondView, thirdView, fourthView]
        for v in objects {
            if v?.backgroundColor != .black {
                v?.backgroundColor = .black
                break
            }
            if viewModel?.colorView.count == 4  {
                createPassword()
                if viewModel?.dictionary != nil {
                    if viewModel?.colorView == viewModel?.dictionary!.first!.value as? String {
                        for el in objects {
                            el?.backgroundColor = .systemGray3
                        }
                        viewModel?.colorView = ""
                        dismiss(animated: false, completion: nil)
                    } else {
                        for el in objects {
                            el?.backgroundColor = .red
                        }
                        labelText.text = "Неверный код доступа"
                        AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                        faceIDButton.setImage(UIImage(systemName: "faceid"), for: .normal)
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    for el in objects {
                        el?.backgroundColor = .systemGray3
                        self.viewModel?.colorView = ""
                    }
                    self.labelText.text = "Введите код доступа"
                }
                break
            }
        }
    }
 
//MARK: FaceID / TouchID
    
    private func indetifyYourself() {
        if dictionary != nil {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Идентифицируйте себя"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                if success {
                    DispatchQueue.main.async { [unowned self] in
                        dismiss(animated: false, completion: nil)
                    }
                }
            }
        } else {
            print("Face/Touch ID не найден")
            }
        } else {
            print("No password")
        }
    }
  
    func face() {
        let switchBool: Bool = UserDefaults.standard.bool(forKey: "FaceIDOn")
           if switchBool {
               indetifyYourself()
           }else{
               print("No faceID")
       }
    }
    
//MARK: Button actions
    
    @IBAction func faceIDAction(_ sender: Any) {
        if viewModel!.colorView.count > 0 {
            let objects = [fourthView, thirdView, secondView, firstView]
            for i in objects {
                if i?.backgroundColor == .black {
                    i?.backgroundColor = .systemGray3
                    break
                }
            }
            viewModel?.colorView.removeLast()
            if viewModel?.colorView.count == 0 {
                faceIDButton.setImage(UIImage(systemName: "faceid"), for: .normal)
            }
        } else {
        let switchBool: Bool = UserDefaults.standard.bool(forKey: "FaceIDOn")
        if switchBool {
            indetifyYourself()
        } else {
            UserDefaults.standard.set(true, forKey: "FaceIDOn")
            UserDefaults.standard.synchronize()
            indetifyYourself()
        }
        }
    }
    
    @IBAction func oneButtonAction(_ sender: Any) {
        viewModel?.oneAction()
        colorizeView()
    }
    @IBAction func twoButtonAction(_ sender: Any) {
        viewModel?.twoAction()
        colorizeView()
    }
    @IBAction func threeButtonAction(_ sender: Any) {
        viewModel?.threeAction()
        colorizeView()
    }
    @IBAction func fourButtonAction(_ sender: Any) {
        viewModel?.fourAction()
        colorizeView()
    }
    @IBAction func fiveButtonAction(_ sender: Any) {
        viewModel?.fiveAction()
        colorizeView()
    }
    @IBAction func sixButtonAction(_ sender: Any) {
        viewModel?.sixAction()
        colorizeView()
    }
    @IBAction func sevenButtonAction(_ sender: Any) {
        viewModel?.sevenAction()
        colorizeView()
    }
    @IBAction func eightButtonAction(_ sender: Any) {
        viewModel?.eightAction()
        colorizeView()
    }
    @IBAction func nineButtonAction(_ sender: Any) {
        viewModel?.nineAction()
        colorizeView()
    }
    @IBAction func zeroButtonAction(_ sender: Any) {
        viewModel?.zeroAction()
        colorizeView()
    }
    @IBAction func forgotButtonAction(_ sender: Any) {
        viewModel?.forgotButton()
        animatePopUp?.animateInSettings(view: view, popUp: popUpView)
    }
  
//MARK: PopUp button actions
    
    @IBAction func popUpShow(_ sender: Any) {
        if popUpTextField.text?.lowercased() == UserDefaults.standard.string(forKey: "CodeWord") {
        viewModel?.popUpShow()
        }
    }
    
    @IBAction func popUpCancelButtonAction(_ sender: Any) {
        animatePopUp?.animateOut(popUp: popUpView)
        viewModel?.popUpCancel()
    }
    
}
