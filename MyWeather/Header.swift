//
//  Header.swift
//  MyWeather
//
//  Created by 심현석 on 2023/03/01.
//

import UIKit
import SnapKit

class Header: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
