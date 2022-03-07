//
//  ConsumptionViewController.swift
//  MyPayment
//
//  Created by Антон Дубино on 19.12.2021.
//

import UIKit

class ConsumptionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var popUpSumTextField: UITextField!
    @IBOutlet weak var popUpNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var popUpCollectionView: UICollectionView!
    @IBOutlet weak var popUpChangeButton: UIButton!
    @IBOutlet weak var popUpSaveButton: UIButton!
    @IBOutlet var miniPopUpView: UIView!
    @IBOutlet weak var miniPopUpName: UILabel!
    @IBOutlet weak var miniPopUpSum: UILabel!
    @IBOutlet weak var miniPopUpDate: UILabel!
    @IBOutlet weak var miniPopUpImageView: UIImageView!
    @IBOutlet weak var miniPopUpChangeButton: UIButton!
    @IBOutlet weak var miniPopUpDeleteButton: UIButton!
    @IBOutlet weak var miniPopUpCancelButton: UIButton!
    
    var viewModel: ConsumptionViewControllerViewModelType? = ConsumptionViewModel()
    var animatePopUp: AnimatePopUp? = PopUp()
    var doneButton: CreateButton? = DoneButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        popUpCollectionView.delegate = self
        popUpCollectionView.dataSource = self
        popUpSumTextField.delegate = self
        self.tableView.register(UINib(nibName: "ConsumptionTableViewCell", bundle: nil), forCellReuseIdentifier: "ConsumptionTableViewCell")
        self.popUpCollectionView.register(UINib(nibName: "ConsumptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ConsumptionImageCell")
        tableView.separatorStyle = .none
        buttonLayers()
        viewModel?.createImages()
        viewModel?.sortedArrayByMonth()
        viewModel?.findSum()
        doneButton?.view = view
        popUpNameTextField.inputAccessoryView = doneButton?.addDoneButtonOnKeyboard()
        popUpSumTextField.inputAccessoryView = doneButton?.addDoneButtonOnKeyboard()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.sortedArrayByMonth()
        viewModel?.findSum()
        tableView.reloadData()
    }

//MARK: Button layers
    
    func buttonLayers() {
        addButton.layer.cornerRadius = 10
        miniPopUpCancelButton.layer.cornerRadius = 10
        miniPopUpChangeButton.layer.cornerRadius = 10
        miniPopUpDeleteButton.layer.cornerRadius = 10
    }
    
//MARK: Binding
    
    func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.visualEffectHidden >>> { self.visualEffectView.isHidden = $0 }
        viewModel.popUpSaveButtonHidden >>> { self.popUpSaveButton.isHidden = $0 }
        viewModel.popUpChangeButtonHidden >>> { self.popUpChangeButton.isHidden = $0 }
        viewModel.popUpSaveButtonEnabled >>> { self.popUpSaveButton.isEnabled = $0 }
        viewModel.popUpChangeButtonEnabled >>> { self.popUpChangeButton.isEnabled = $0 }
    }
    
    func bindPopup() {
        guard let viewModel = viewModel else { return }
        viewModel.popUpNameTextFieldText >>> { self.popUpNameTextField.text = $0 }
        viewModel.popUpSumTextFieldText >>> { self.popUpSumTextField.text = $0 }
        viewModel.datePickerDate >>> { self.datePicker.date = $0 }
    }
    
    func bindMiniPopUp() {
        guard let viewModel = viewModel else { return }
        viewModel.miniPopUpNameText >>> { self.miniPopUpName.text = $0 }
        viewModel.miniPopUpSumText >>> { self.miniPopUpSum.text = $0 }
        viewModel.miniPopUpDateText >>> { self.miniPopUpDate.text = $0 }
        viewModel.miniPopUpImageViewText >>> { self.miniPopUpImageView.image = UIImage(named: $0) }
    }
    
//MARK: Save item in Realm
    
    func saveItem() {
        let item = ConsumptionData()
        if popUpNameTextField.text == "" {
            item.name = "Расход"
        } else {
            item.name = popUpNameTextField.text!
        }
        item.sum = popUpSumTextField.text!
        item.date = datePicker.date
        item.image = viewModel?.image ?? ""
        viewModel?.consumptionData.save(item: item)
        viewModel?.popUpSave()
        datePicker.date = .now
        animatePopUp?.animateOut(popUp: popUpView)
        bindPopup()
        tableView.reloadData()
        popUpCollectionView.reloadData()
    }

//MARK: Button actions
    
    @IBAction func addButtonAction(_ sender: Any) {
        viewModel?.addButton()
        datePicker.date = .now
        animatePopUp?.animateIn(view: view, popUp: popUpView)
        viewModel?.findSum()
        popUpCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    @IBAction func popUpCancelButtonAction(_ sender: Any) {
        datePicker.date = .now
        viewModel?.popUpCancel()
        animatePopUp?.animateOut(popUp: popUpView)
        bindPopup()
        tableView.reloadData()
        popUpCollectionView.reloadData()
    }
    
    @IBAction func popUpSaveButtonAction(_ sender: Any) {
        saveItem()
    }
    
    @IBAction func popUpChangeButtonAction(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        for i in viewModel.consumptionData.getItems() {
            if i.date == viewModel.itemDate && i.date?.seconds == viewModel.itemSeconds {
                viewModel.consumptionData.remove(item: i)
               saveItem()
            }
        }
    }
    
    @IBAction func miniPopUpCancelButtonAction(_ sender: Any) {
        viewModel?.miniPopUpCancel()
        animatePopUp?.animateOut(popUp: miniPopUpView)
    }
    
    @IBAction func miniPopUpDeleteButtonAction(_ sender: Any) {
        viewModel?.miniPopUpDelete()
        tableView.reloadData()
        animatePopUp?.animateOut(popUp: miniPopUpView)
    }
    
    @IBAction func moniPopUpChangeButtonAction(_ sender: Any) {
        bindPopup()
        miniPopUpView.removeFromSuperview()
        animatePopUp?.animateIn(view: view, popUp: popUpView)
        viewModel?.miniPopUpChange()
        popUpCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
}

//MARK: UITableViewDelegate

extension ConsumptionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.tableViewNumberOfSections() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.tableViewnumberOfRowsInSection(section) ?? 0

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.tableViewTitleForHeaderInSection(section) ?? ""
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel?.tableViewTitleForFooterInSection(section) ?? ""
    }

    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.font = .systemFont(ofSize: 17, weight: .thin)
        header.textLabel?.textAlignment = NSTextAlignment.right
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsumptionTableViewCell") as! ConsumptionTableViewCell
        cell.selectionStyle = .none
        guard let viewModel = viewModel else { return UITableViewCell() }
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        for i in viewModel.consumptionData.getItems() {
            if i.date == item.date && i.date?.seconds == item.date.seconds {
                cell.nameLabel.text = i.name
                cell.sumLabel.text = i.sum
                cell.imageCell.image = UIImage(named: i.image)
                cell.dateLabel.text = viewModel.sections[indexPath.section].items[indexPath.row].title
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        visualEffectView.isHidden = false
        viewModel?.tableViewDidSelectRowAt(indexPath)
        bindMiniPopUp()
        animatePopUp?.animateInMini(view: view, popUp: miniPopUpView)
    }

}

//MARK: UICollectionViewDelegate

extension ConsumptionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.collectionViewNumberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = popUpCollectionView.dequeueReusableCell(withReuseIdentifier: "ConsumptionImageCell", for: indexPath) as? ConsumptionCollectionViewCell
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

//MARK: UITextFieldDelegate

extension ConsumptionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == popUpSumTextField {
            viewModel?.textFieldShouldChangeCharactersIn(string)
            guard let viewModel = viewModel else { return true }
            viewModel.popUpSumTextFieldText >>> { self.popUpSumTextField.text = $0 }
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !popUpSumTextField.text!.isEmpty && !popUpNameTextField.text!.isEmpty {
            popUpSaveButton.isEnabled = true
            popUpChangeButton.isEnabled = true
        } else {
            popUpSaveButton.isEnabled = false
            popUpChangeButton.isEnabled = false
        }
    }
}
