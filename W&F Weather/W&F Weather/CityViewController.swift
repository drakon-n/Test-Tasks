//
//  CityViewController.swift
//  W&F Weather
//
//  Created by Влад on 08.09.2021.
//

import UIKit
import Kingfisher

class CityViewController: UIViewController {
    var searched: Bool = false
    let cityLabel = UILabel()
    let weatherConditionLabel = UILabel()
    let tempLabel = UILabel()
    let minMaxTempLabel = UILabel()
    let sunRiseLabel = UILabel()  //время восхода
    let sunSetLabel = UILabel()  //время заката
    let sunRiseDesc = UILabel()
    let sunSetDesc = UILabel()
    let feelsLikeDesc = UILabel()
    let feelsLikeLabel = UILabel()
    let kfButton = UIButton() //надо же куда-то подс прикрутить
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if (searched){setupData(sourse: searchedCity[index])}
        else{setupData(sourse: cityData[index])}
        searched = false
    }
    
    func setupData(sourse: WeatherData){
        cityLabel.text = sourse.geo_object.locality.name
        tempLabel.text = String(sourse.fact.temp) + "°"
        minMaxTempLabel.text = "Макс. " + String(sourse.forecasts[0].parts.evening.temp_max) + "°, мин. " + String(sourse.forecasts[0].parts.night.temp_min) + "°"
        sunRiseLabel.text = sourse.forecasts[0].sunrise
        sunSetLabel.text = sourse.forecasts[0].sunset
        feelsLikeLabel.text = String(sourse.fact.feels_like) + "°"
        weatherConditionLabel.text = weatherTranslate[sourse.fact.condition]
    }
    
    
    func setupView(){
        cityLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width*0.7, height: view.safeAreaLayoutGuide.layoutFrame.size.height)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cityLabel)
        cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cityLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95).isActive = true
        cityLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07).isActive = true
        cityLabel.textAlignment = .center
        cityLabel.font = UIFont(descriptor: cityLabel.font.fontDescriptor, size: 35)
        cityLabel.textColor = .white
        
        self.view.addSubview(weatherConditionLabel)
        weatherConditionLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherConditionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: -5).isActive = true
        weatherConditionLabel.centerXAnchor.constraint(equalTo: cityLabel.centerXAnchor).isActive = true
        weatherConditionLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.6).isActive = true
        weatherConditionLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
        weatherConditionLabel.textAlignment = .center
        weatherConditionLabel.font = UIFont(descriptor: cityLabel.font.fontDescriptor, size: 20)
        weatherConditionLabel.textColor = .white
        
        self.view.addSubview(tempLabel)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.topAnchor.constraint(equalTo: weatherConditionLabel.bottomAnchor).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: cityLabel.centerXAnchor).isActive = true
        tempLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        tempLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15).isActive = true
        tempLabel.textAlignment = .center
        tempLabel.font = UIFont.systemFont(ofSize: 100, weight: UIFont.Weight.thin)
        tempLabel.textColor = .white
        
        self.view.addSubview(minMaxTempLabel)
        minMaxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        minMaxTempLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor).isActive = true
        minMaxTempLabel.centerXAnchor.constraint(equalTo: cityLabel.centerXAnchor).isActive = true
        minMaxTempLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
        minMaxTempLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
        minMaxTempLabel.textAlignment = .center
        minMaxTempLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.thin)
        minMaxTempLabel.textColor = .white
        
        self.view.addSubview(sunRiseDesc)
        sunRiseDesc.translatesAutoresizingMaskIntoConstraints = false
        sunRiseDesc.topAnchor.constraint(equalTo: minMaxTempLabel.bottomAnchor, constant: 10).isActive = true
        sunRiseDesc.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        sunRiseDesc.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        sunRiseDesc.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.03).isActive = true
        sunRiseDesc.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
        sunRiseDesc.text = "ВОСХОД СОЛНЦА"
        sunRiseDesc.textColor = .systemGray5
        
        self.view.addSubview(sunRiseLabel)
        sunRiseLabel.translatesAutoresizingMaskIntoConstraints = false
        sunRiseLabel.topAnchor.constraint(equalTo: sunRiseDesc.bottomAnchor).isActive = true
        sunRiseLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        sunRiseLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        sunRiseLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.04).isActive = true
        sunRiseLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        sunRiseLabel.textColor = .white
        
        self.view.addSubview(sunSetDesc)
        sunSetDesc.translatesAutoresizingMaskIntoConstraints = false
        sunSetDesc.topAnchor.constraint(equalTo: sunRiseLabel.bottomAnchor, constant: 10).isActive = true
        sunSetDesc.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        sunSetDesc.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        sunSetDesc.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.03).isActive = true
        sunSetDesc.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
        sunSetDesc.text = "ЗАХОД СОЛНЦА"
        sunSetDesc.textColor = .systemGray5
        
        self.view.addSubview(sunSetLabel)
        sunSetLabel.translatesAutoresizingMaskIntoConstraints = false
        sunSetLabel.topAnchor.constraint(equalTo: sunSetDesc.bottomAnchor).isActive = true
        sunSetLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        sunSetLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        sunSetLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.04).isActive = true
        sunSetLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        sunSetLabel.textColor = .white
        
        self.view.addSubview(feelsLikeDesc)
        feelsLikeDesc.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeDesc.topAnchor.constraint(equalTo: sunSetLabel.bottomAnchor, constant: 10).isActive = true
        feelsLikeDesc.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        feelsLikeDesc.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        feelsLikeDesc.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.03).isActive = true
        feelsLikeDesc.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.thin)
        feelsLikeDesc.text = "ОЩУЩАЕТСЯ КАК"
        feelsLikeDesc.textColor = .systemGray5
        
        self.view.addSubview(feelsLikeLabel)
        feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLikeLabel.topAnchor.constraint(equalTo: feelsLikeDesc.bottomAnchor).isActive = true
        feelsLikeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        feelsLikeLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
        feelsLikeLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.04).isActive = true
        feelsLikeLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        feelsLikeLabel.textColor = .white
        
        //ну и так далее, хотя по хорошему надо конечно сделать тэйбл вьюху и не верстать одно и то же
        
        self.view.addSubview(kfButton)
        kfButton.translatesAutoresizingMaskIntoConstraints = false
        kfButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        kfButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        kfButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        kfButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        kfButton.backgroundColor = .red
        kfButton.setTitle("KF", for: .normal)
        kfButton.addTarget(self, action:#selector(showImage), for: UIControl.Event.touchUpInside)
        
        self.view.backgroundColor = .systemGray
        
    }
    
    
    @objc func showImage(sender: UIButton){
        let testVK = UIViewController()
        testVK.view.backgroundColor = .white
        navigationController?.pushViewController(testVK, animated: true)
        let imageTest = UIImageView()
        testVK.view.addSubview(imageTest)
        imageTest.frame = CGRect(x: testVK.view.bounds.width*0.25, y: testVK.view.bounds.height*0.4, width: testVK.view.bounds.width*0.5, height: testVK.view.bounds.height*0.2)
        let justLabel = UILabel()
        testVK.view.addSubview(justLabel)
        justLabel.frame = CGRect(x: testVK.view.bounds.width*0.1, y: testVK.view.bounds.height*0.3, width: testVK.view.bounds.width*0.8, height: testVK.view.bounds.height*0.1)
        justLabel.textAlignment = .center
        justLabel.numberOfLines = 0
        justLabel.text = "Тут типа картинка, загруженная Кингфишером"
        let url = URL(string: "https://www.fish-hook.ru/editable/users/1i/d9/irzb29wk8ggok84.jpeg")
        imageTest.kf.setImage(with: url)
        
    }
    

}
