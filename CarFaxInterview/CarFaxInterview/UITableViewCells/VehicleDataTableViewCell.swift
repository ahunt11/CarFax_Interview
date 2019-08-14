//
// VehicleDataTableViewCell.swift
// CarFaxInterview
//
// Created by My Name and Ohter Name on 8/12/19.
// Copyright © 2019 Your Company Name. All rights reserved.
//

import UIKit
import RxSwift

protocol TableViewCellIdentifiable {
    static var identifier: String { get }
}

extension TableViewCellIdentifiable {
    static var identifier: String {
        return "\(Self.self)"
    }
}

class VehicleDataTableViewCell: UITableViewCell, TableViewCellIdentifiable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var vehicleInfoLabel: UILabel!
    @IBOutlet weak var phoneNumberButton: UIButton!
    
    private(set) var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }
    
    func setupLayout(vehicleModel: VehicleModelWithImage) {
        let vehicle = vehicleModel.vehicleModel
        vehicleNameLabel.text = vehicle.modelName
        vehicleInfoLabel.text = vehicle.modelInfo
        phoneNumberButton.setTitle(vehicle.dealer?.phone, for: .normal)
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
        containerView.layer.borderColor = UIColor.blue.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 10
        if let image = vehicleModel.image {
            vehicleImage?.image = image
        }
    }
}
