//
//  Cell.swift
//  MyWeather
//
//  Created by 심현석 on 2023/02/28.
//

import UIKit

class Cell: UITableViewCell {
    
    var dayLabel: UILabel!
    var timetext: UILabel!
    var iconImageView: UIImageView!
    var highTempLabel: UILabel!
    var lowTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with model: Datum) {

        dayLabel.text = getDay(Date(timeIntervalSince1970: Double(model.time)))
        timetext.text = getDate(Date(timeIntervalSince1970: Double(model.time)))
        
        let icon = model.icon
        if icon.contains("clear") {
            iconImageView.image = UIImage(named: "sun")
        } else if icon.contains("rain") {
            iconImageView.image = UIImage(named: "rain")
        } else {
            iconImageView.image = UIImage(named: "cloud")
        }
        
        lowTempLabel.text = "\(String(format: "%.1f", model.temperatureMin))°"
        lowTempLabel.textAlignment = .center
        highTempLabel.text = "\(String(format: "%.1f", model.temperatureMax))°"
        highTempLabel.textAlignment = .center
    }
    
    func getDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M-d"
        return formatter.string(from: date)
    }
    
    func getDay(_ date: Date?) -> String {
            guard let inputDate = date else {
                return ""
            }

            let formatter = DateFormatter()
            formatter.dateFormat = "E"
            return formatter.string(from: inputDate)
        }
}
