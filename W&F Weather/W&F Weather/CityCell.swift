//
//  CityCell.swift
//  W&F Weather
//
//  Created by Влад on 07.09.2021.
//

import UIKit

class CityCell: UITableViewCell {
    
    var cityName = UILabel()
    var cityTemp = UILabel()
    var cityWeather = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(){
        self.addSubview(cityName)
        self.addSubview(cityWeather)
        self.addSubview(cityTemp)
        
        cityName.frame = CGRect(x: self.bounds.width*0.1, y: 10, width: self.bounds.width*0.7, height: self.bounds.height)
        cityName.translatesAutoresizingMaskIntoConstraints = false
        cityName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cityName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        cityName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cityName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        cityName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        cityName.font = UIFont(name: cityName.font.fontName, size: 25)
        
        cityTemp.frame = CGRect(x: self.bounds.width*0.8, y: 0, width: self.bounds.width*0.2, height: self.bounds.height)
        cityTemp.translatesAutoresizingMaskIntoConstraints = false
        cityTemp.trailingAnchor.constraint(equalTo: cityWeather.leadingAnchor, constant: -5).isActive = true
        cityTemp.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        cityTemp.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        cityTemp.widthAnchor.constraint(equalTo: cityTemp.heightAnchor, multiplier: 1.4).isActive = true
        cityTemp.font = UIFont(name: cityName.font.fontName, size: 30)
        cityTemp.center.y = self.center.y
        cityTemp.textAlignment = .right
        
        
        
        cityWeather.frame = CGRect(x: 0.9, y: 10, width: self.bounds.width*0.15, height: self.bounds.height)
        //cityWeather.backgroundColor = .red
        cityWeather.translatesAutoresizingMaskIntoConstraints = false
        cityWeather.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        cityWeather.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        cityWeather.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        cityWeather.widthAnchor.constraint(equalTo: cityWeather.heightAnchor, multiplier: 1.0).isActive = true
        cityWeather.image = UIImage(named: "sun")
        
    }
    
    func fillcell(data: WeatherData){
        
    }
}
