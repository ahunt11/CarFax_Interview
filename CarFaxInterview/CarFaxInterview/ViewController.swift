//
// ViewController.swift
// 
//
// Created by My Name and Ohter Name on 8/8/19.
// Copyright © 2019 Your Company Name. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let vehicleListViewModel: VehicleListViewable = VehicleListViewModel()
    private let bag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.barTintColor = .blue

    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Car Fax Interview Assignment"
        
        
        tableView.register(UINib(nibName: VehicleDataTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: VehicleDataTableViewCell.identifier)
        tableView.allowsSelection = false
        
        vehicleListViewModel.fetchListOfVehicles()
            .concatMap{ [weak self] (models: [VehicleModel]) -> Observable<[VehicleModelWithImage]> in
                guard let self = self else{ return .empty()}
                return self.vehicleListViewModel.fetchVehicleModelsWithImages(vehicleModels: models)
            }
            .bind(to: tableView.rx.items(cellIdentifier: VehicleDataTableViewCell.identifier, cellType: VehicleDataTableViewCell.self)) { (row: Int, element: VehicleModelWithImage, cell: VehicleDataTableViewCell) -> Void in
                cell.setupLayout(vehicleModel: element)
                cell.phoneNumberButton.rx.tap
                    .subscribe(onNext: {
                        if let number = cell.phoneNumberButton.titleLabel?.text,
                            let url = URL(string: "tel://\(number)") {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }).disposed(by: cell.bag)
        }.disposed(by: bag)
    }


}

