//
//  ViewController.swift
//  W&F Weather
//
//  Created by Влад on 06.09.2021.
//

import UIKit

var cityList = ["Москва","Воронеж","Омск","Тверь","Сызрань"]

class ViewController: UIViewController {
    var cityTable: UITableView = UITableView()
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    var navigationBar: UINavigationItem = UINavigationItem()
        
    
        
    var searching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityTable.dataSource = self
        self.cityTable.delegate = self
        for elm in 0 ... coordinate.count-1{
            self.req(index: elm)
        }
        
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if update == true{
            for i in cityData.count ... coordinate.count-1{
                req(index: i)
            }
            update = false
        }
        cityTable.reloadData()
    }

    func setupView(){
        //navigationBar = UINavigationItem(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        
        cityTable.translatesAutoresizingMaskIntoConstraints = false
        cityTable.frame = CGRect(x: 0, y: 25, width: self.view.bounds.width, height: self.view.bounds.height-20)
        self.view.addSubview(cityTable)
        //cityTable.topAnchor.constraint(equalTo: self.)
        
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
    }
    

}

extension ViewController:UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
                    return searchedCity.count
                } else {
                    return cityData.count
                }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CityCell()
        cell.setupCell()
        if searching {
            cell.cityName.text = searchedCity[indexPath.row].geo_object.locality.name
            cell.cityTemp.text = String(searchedCity[indexPath.row].fact.temp) + "℃"
            cell.cityWeather.image = UIImage(named: "\(weatherImage[searchedCity[indexPath.row].fact.condition] ?? "sun")")
        } else {
            cell.cityName.text = cityData[indexPath.item].geo_object.locality.name
            cell.cityTemp.text = String(cityData[indexPath.row].fact.temp) + "℃"
            cell.cityWeather.image = UIImage(named: "\(weatherImage[cityData[indexPath.row].fact.condition] ?? "sun")")
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height * 0.095
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.searchTextField.endEditing(true)
        let vc = CityViewController()
        if(searching){vc.searched = true}
        vc.view.frame = vc.view.safeAreaLayoutGuide.layoutFrame
        navigationController?.pushViewController(vc, animated: true)
        vc.index = indexPath.item
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedCity = cityData.filter{ $0.geo_object.locality.name.lowercased().prefix(searchText.count) == searchText.lowercased() }
            searching = true
            cityTable.reloadData()
        }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searching = false
            searchBar.text = ""
            cityTable.reloadData()
        }
    
    func req (index: Int) {
        DispatchQueue.global().async{
            guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast/?lat=\(coordinate[index].lat)&lon=\(coordinate[index].lon)&lang=ru_RU&limit=1&hours=false") else {return}
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("d8597f32-e88d-4f60-82e6-9dc23e9f8d44", forHTTPHeaderField: "X-Yandex-API-Key")
            let session = URLSession.shared
            session.dataTask(with: request){data,responce,error in
           /* if let responce = responce{
                print(responce)
            } */
                do {
                    guard let data = data else {return}
                    //let json = try JSONSerialization.jsonObject(with: data, options: [])
                    //print(json)
                    let jsonResult = try JSONDecoder().decode(WeatherData.self, from:data )
                    DispatchQueue.main.async {
                        cityData.append(jsonResult)
                        self.cityTable.reloadData()
                    }
                }catch{
                    print(error)
                    DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ошибка", message: "Населенный пункт не найден", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                    }
                }
            
            }.resume()
            
        }
        
    }
    
    @objc func addTapped(sender: UIButton){
        let VK = AddCityController()
        VK.view.backgroundColor = .white
        let latLabel = UILabel()
        let lonLabel = UILabel()
        //navigationController?.present(VK, animated: true, completion: nil)
        navigationController?.pushViewController(VK, animated: true)
        VK.view.addSubview(latLabel)
        VK.view.addSubview(lonLabel)
        VK.view.addSubview(VK.latField)
        VK.view.addSubview(VK.lonField)
        
        latLabel.frame = CGRect(x: VK.view.bounds.width*0.25, y: VK.view.bounds.height*0.1, width: VK.view.bounds.width*0.5, height: VK.view.bounds.height*0.1)
        latLabel.text = "Широта:"
        VK.latField.frame = CGRect(x: VK.view.bounds.width*0.25, y: VK.view.bounds.height*0.2, width: VK.view.bounds.width*0.5, height: VK.view.bounds.height*0.06)
        VK.latField.backgroundColor = .systemGray6
        lonLabel.frame = CGRect(x: VK.view.bounds.width*0.25, y: VK.view.bounds.height*0.26, width: VK.view.bounds.width*0.5, height: VK.view.bounds.height*0.1)
        lonLabel.text = "Долгота:"
        VK.lonField.frame = CGRect(x: VK.view.bounds.width*0.25, y: VK.view.bounds.height*0.36, width: VK.view.bounds.width*0.5, height: VK.view.bounds.height*0.06)
        VK.lonField.backgroundColor = .systemGray6
        
        
    }
    
    
    
}

