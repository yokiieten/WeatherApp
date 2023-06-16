//
//  ForeCastTableViewCell.swift
//  WeatherApp
//
//  Created by Sahassawat on 15/6/2566 BE.
//

import UIKit

class ForeCastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func config(weatherModel: WeatherModel) {
       let datetime = DateFormatComponent().format(dateString: weatherModel.date ?? "", sourcePattern: .timeAPIWeather, destinationPattern: .fullDateTimeTH).lowercased()
        date.text = datetime
        cityLabel.text = weatherModel.cityName
        temperatureLabel.text = weatherModel.temperatureString
        conditionImageView.image = UIImage(systemName: weatherModel.conditionName)
    }
}
