//
//  AddCityController.swift
//  W&F Weather
//
//  Created by Влад on 09.09.2021.
//

import UIKit

class AddCityController: UIViewController {
    
    let latField = UITextField()
    let lonField = UITextField()
    let addButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(addButton)
        addButton.frame = CGRect(x: self.view.bounds.width*0.25, y: self.view.bounds.height*0.48, width: self.view.bounds.width*0.5, height: self.view.bounds.height*0.1)
        addButton.setTitle("Добавить", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = .systemGray6
        addButton.addTarget(self, action:#selector(addCity), for: UIControl.Event.touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    @objc func addCity(sender: UIButton){
        let alert = UIAlertController(title: "Ошибка", message: "Неверно введенные данные", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        if let _ = Float(latField.text!) {
            
        }else{
            present(alert, animated: true, completion: nil)
            return
        }
        if let _ = Float(lonField.text!){
            
        }else{
            present(alert, animated: true, completion: nil)
            return
        }
        if(Float(latField.text!)!>90)||(Float(latField.text!)!<0)||(Float(lonField.text!)!<0)||(Float(lonField.text!)!>180){
            present(alert, animated: true, completion: nil)
            return
        }
        coordinate.append(CitySourse(lat: Float(latField.text!)!, lon: Float(lonField.text!)!))
        update = true
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
