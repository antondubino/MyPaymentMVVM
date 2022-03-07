//
//  CalculateViewController.swift
//  MyPayment
//
//  Created by Антон Дубино on 20.12.2021.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var payment: UILabel!
    @IBOutlet weak var creditAmount: UILabel!
    @IBOutlet weak var interest: UILabel!
    @IBOutlet weak var creditAmountWithPercent: UILabel!
    @IBOutlet weak var totalCost: UITextField!
    @IBOutlet weak var initial: UITextField!
    @IBOutlet weak var term: UITextField!
    @IBOutlet weak var bid: UITextField!
    @IBOutlet weak var rubleButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var monthsButton: UIButton!
    @IBOutlet weak var yearsButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var superPaymentView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var popUpNameTextField: UITextField!
    @IBOutlet weak var popUpDatePicker: UIDatePicker!
    @IBOutlet weak var popUpCollectionView: UICollectionView!
    @IBOutlet weak var popUpSaveButton: UIButton!
    
    var viewModel: CalculateViewControllerViewModelType? = CalculateViewModel()
    var animatePopUp: AnimatePopUp? = PopUp()
    var doneButton: CreateButton? = DoneButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalCost.delegate = self
        initial.delegate = self
        term.delegate = self
        bid.delegate = self
        popUpNameTextField.delegate = self
        popUpCollectionView.delegate = self
        popUpCollectionView.dataSource = self
        self.popUpCollectionView.register(UINib(nibName: "CalculateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CalculateImageCell")
        viewModel?.createImages()
        viewModel?.culcResultYears()
        buttonLayers()
        doneButton?.view = view
        totalCost.inputAccessoryView = doneButton?.addDoneButtonOnKeyboard()
        initial.inputAccessoryView = doneButton?.addDoneButtonOnKeyboard()
        term.inputAccessoryView = doneButton?.addDoneButtonOnKeyboard()
        bid.inputAccessoryView = doneButton?.addDoneButtonOnKeyboard()
        popUpNameTextField.inputAccessoryView = doneButton?.addDoneButtonOnKeyboard()
        totalCost.placeholder = viewModel?.updateAmountTotalCost()
        initial.placeholder = viewModel?.updateAmountInitial()
        bid.placeholder = viewModel?.updateBid()
        bind()
    }
    
//MARK: Button layers
    
    func buttonLayers() {
        saveButton.layer.cornerRadius = 10
        superPaymentView.layer.cornerRadius = 10
        paymentView.layer.cornerRadius = 10
        popUpView.layer.cornerRadius = 10
    }
 
//MARK: Binding
    
    func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.popUpNameTextFieldText >>> { self.popUpNameTextField.text = $0 }
        viewModel.totalCostText >>> { self.totalCost.text = $0 }
        viewModel.initialText >>> { self.initial.text = $0 }
        viewModel.termText >>> { self.term.text = $0 }
        viewModel.bidText >>> { self.bid.text = $0 }
        viewModel.yearsButton >>> { self.yearsButton.isEnabled = $0 }
        viewModel.monthsButton >>> { self.monthsButton.isEnabled = $0 }
        viewModel.saveButton >>> { self.saveButton.isEnabled = $0 }
        viewModel.paymentText >>> { self.payment.text = $0 }
        viewModel.creditAmountText >>> { self.creditAmount.text = $0 }
        viewModel.creditAmountWithPercentText >>> { self.creditAmountWithPercent.text = $0 }
        viewModel.interestText >>> { self.interest.text = $0 }
        viewModel.termPlaceholder >>> { self.term.placeholder = $0 }
        viewModel.initialPlaceholder >>> { self.initial.placeholder = $0 }
        viewModel.visualEffectHidden >>> { self.visualEffectView.isHidden = $0 }
        viewModel.popUpSaveButtonEnabled >>> {
            self.popUpSaveButton.isEnabled = $0
        }
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        viewModel?.saveButtonAction()
        animatePopUp?.animateIn(view: view, popUp: popUpView)
        popUpCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @IBAction func popUpCancelButtonAction(_ sender: Any) {
        viewModel?.popUpCancel()
        animatePopUp?.animateOut(popUp: popUpView)
    }
    
    @IBAction func popUpSaveButton(_ sender: Any) {
        let item = ConsumptionData()
        item.name = popUpNameTextField.text!
        item.sum = payment.text!
        item.date = popUpDatePicker.date
        item.image = viewModel?.image ?? ""
        viewModel?.data.save(item: item)
        popUpDatePicker.date = .now
        viewModel?.popUpSave()
        animatePopUp?.animateOut(popUp: popUpView)
        popUpCollectionView.reloadData()
    }
    
//MARK: Initial actions
    
    @IBAction func toRoubleButton(_ sender: Any) {
        viewModel?.toRoubleAction()
        rubleButton.setTitleColor(.red, for: .normal)
        percentButton.setTitleColor(.darkGray, for: .normal)
    }
    
    @IBAction func toPercentButton(_ sender: Any) {
        viewModel?.toPercentAction()
        percentButton.setTitleColor(.red, for: .normal)
        rubleButton.setTitleColor(.darkGray, for: .normal)
    }
    
    
//MARK: Term actions
    
    @IBAction func toMonthsButton(_ sender: Any) {
        viewModel?.toMonthsAction()
        monthsButton.setTitleColor(.red, for: .normal)
        yearsButton.setTitleColor(.darkGray, for: .normal)
    }
    
    @IBAction func toYearsButton(_ sender: Any) {
        viewModel?.toYearsAction()
        yearsButton.setTitleColor(.red, for: .normal)
        monthsButton.setTitleColor(.darkGray, for: .normal)
    }
}

//MARK: UITextFieldDelegate

extension CalculateViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == totalCost {
            viewModel?.amountTotalCost(string: string)
            return false
        }
        if textField == initial {
            viewModel?.amountInitial(string: string)
            return false
        }
        if textField == term {
            viewModel?.amountTerm(string: string)
            return false
        }
        if textField == bid {
            viewModel?.amountBid(string: string)
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if popUpNameTextField.text!.isEmpty {
            popUpSaveButton.isEnabled = false
        } else {
            popUpSaveButton.isEnabled = true
        }
    }
}

//MARK: UICollectionViewDelegate

extension CalculateViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.collectionViewNumberOfItemsInSection() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = popUpCollectionView.dequeueReusableCell(withReuseIdentifier: "CalculateImageCell", for: indexPath) as? CalculateCollectionViewCell
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        let cellViewModel = viewModel.collectionViewCellForItemAt(indexPath)
        collectionViewCell.viewModel = cellViewModel
        if viewModel.selectedIndexPathItem == indexPath {
            cell?.image.alpha = 1
        } else {
            cell?.image.alpha = 0.3
        }
        return collectionViewCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.collectionViewDidSelectItemAt(indexPath)
        collectionView.reloadData()
    }
}
