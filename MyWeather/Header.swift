//
//  Header.swift
//  MyWeather
//
//  Created by 심현석 on 2023/03/01.
//

import UIKit
import SnapKit

class Header: UICollectionReusableView {

    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "제목"
        lb.font = UIFont.boldSystemFont(ofSize: 17)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

