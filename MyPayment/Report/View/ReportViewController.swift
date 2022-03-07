//
//  ReportViewController.swift
//  MyPayment
//
//  Created by Антон Дубино on 26.12.2021.
//

import UIKit
import Charts

class ReportViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var consumptionLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var superPaymentView: UIView!
    @IBOutlet weak var paymentView: UIView!
    
    var viewModel: ReportViewControllerViewModelType? = ReportViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ReportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReportCell")
        buttonLayers()
        viewModel?.createDates()
        viewModel?.addValues()
        viewModel?.drow(view: pieChartView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel else { return }
        viewModel.createDates()
        viewModel.addValues()
        viewModel.drow(view: pieChartView)
        bind()
        collectionView.reloadData()
    }
    
//MARK: Button layers
    
    func buttonLayers() {
        superPaymentView.layer.cornerRadius = 10
        paymentView.layer.cornerRadius = 10
    }
  
//MARK: Binding
    
    func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.incomeText >>> { self.incomeLabel.text = $0 }
        viewModel.consumptionText >>> { self.consumptionLabel.text = $0 }
        viewModel.totalText >>> { self.totalLabel.text = $0 }
    }
    
}

//MARK: UICollectionViewDelegate

extension ReportViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.collectionViewNumberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReportCell", for: indexPath) as? ReportCollectionViewCell
        guard let collectionViewCell = cell, let viewModel = viewModel else { return UICollectionViewCell() }
        let cellViewModel = viewModel.collectionViewCellForItemAt(indexPath)
        collectionViewCell.viewModel = cellViewModel
        if viewModel.selectedIndex == indexPath.row{
            collectionViewCell.monthAndYearLabel.font = .boldSystemFont(ofSize: 20)
            collectionViewCell.monthAndYearLabel.textColor = .systemTeal
        } else {
            collectionViewCell.monthAndYearLabel.font = .boldSystemFont(ofSize: 10)
            collectionViewCell.monthAndYearLabel.textColor = .black
        }
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel?.collectionViewMinimumLineSpacingForSectionAt() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.collectionViewDidSelectItemAt(indexPath)
        bind()
        viewModel?.drow(view: pieChartView)
        self.collectionView.reloadData()
    }
}
