//
//  CollectionCellView.swift
//  Neobis_IOS_WeatherApp
//
//  Created by Bermet Toichubekova on 13/9/23.
//

import Foundation
import UIKit

class CollectionCellView: UICollectionViewCell {
    
    private lazy var labelDate: UILabel = {
        let label = UILabel()
        label.text = "Sanday"
        return label
    }()
    private lazy var imageIcon: UIImageView = {
        let image = UIImageView()
//        image.image = UIImage(named: "")
        image.backgroundColor = .black
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(labelDate)
        addSubview(imageIcon)
        
    }
    
    func setupConstraints() {
        labelDate.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        imageIcon.snp.makeConstraints { make in
            make.top.equalTo(labelDate.snp.bottom).offset(5)
            make.centerX.equalToSuperview() 
        }
    }

}
