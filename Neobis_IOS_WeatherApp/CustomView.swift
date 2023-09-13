//
//  CustomView.swift
//  Neobis_IOS_WeatherApp
//
//  Created by Bermet Toichubekova on 13/9/23.
//

import Foundation
import UIKit
class CustomView: UIView {
    
    private lazy var staticLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    func setup(staticText: String, data: String) {
        staticLabel.text = staticText
        dataLabel.text = data
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(staticLabel)
        addSubview(dataLabel)
        staticLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
        }
        dataLabel.snp.makeConstraints { (make) in
            make.top.equalTo(staticLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

