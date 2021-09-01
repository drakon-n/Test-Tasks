//
//  BucketViewController.swift
//  test_shop
//
//  Created by Влад on 30.08.2021.
//

import UIKit
import CoreData

class BucketViewController: UIViewController{

    @IBOutlet var finalPriceLabel: UILabel!
    @IBOutlet weak var BucketCollectionView: UICollectionView!
    var quantityStack:[Int] = []
    var inStackNumber = 0
    var totalPrice:Float = 0
    override func viewDidLoad() {
        inStackNumber = 0
        super.viewDidLoad()
        self.BucketCollectionView.register(UINib(nibName: "BucketCell", bundle: nil), forCellWithReuseIdentifier: "BucketCell")
        self.BucketCollectionView.dataSource = self
        self.BucketCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        inStackNumber = 0
        while(quantityStack.count < basketData.count){
            quantityStack.append(1)
        }
        totalPrice = 0
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Good")
        do{
            basketData = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Failed to save \(error)")
        }
        self.BucketCollectionView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        finalPriceLabel.text = String(totalPrice)
        //self.BucketCollectionView.reloadData()
    }
    
}
    
extension BucketViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CustomCellUpdater{
    func justReload() {
        BucketCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return basketData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        while(quantityStack.count < basketData.count){
            quantityStack.append(1)
        }
        let cell = BucketCollectionView.dequeueReusableCell(withReuseIdentifier: "BucketCell", for: indexPath) as! BucketCell
        cell.delegate = self
        cell.basketImage.image = UIImage(data: basketData[indexPath.item].value(forKey: "image") as! Data)
        cell.BasketName.text = basketData[indexPath.item].value(forKey: "name") as? String
        cell.price = basketData[indexPath.item].value(forKey: "price") as! String
        cell.stackNumber = inStackNumber
        cell.basketPrice.text = cell.price
        cell.price = cell.price.components(separatedBy: " ")[0]
        //cell.numberGoods.text = String((basketData[indexPath.item].value(forKey: "num") as? Int)!)
        cell.numberGoods.text = String(quantityStack[indexPath.item])
        cell.updateFinalPrice()
        cell.number = quantityStack[indexPath.item]
        totalPrice = totalPrice + (Float(cell.price) ?? 0)*Float(quantityStack[indexPath.item])
        inStackNumber = inStackNumber + 1
        cell.layer.cornerRadius = 8.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.width*0.45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    func updateTableView(price: Float, isIncrement:Bool, queue:Int ) {
        inStackNumber = 0
        let summa:Float = Float(finalPriceLabel.text ?? "0")! + price
        finalPriceLabel.text = String(summa)
        if (isIncrement){
            quantityStack[queue] = quantityStack[queue] + 1
        }
        else{
            quantityStack[queue] = quantityStack[queue] - 1
            if(quantityStack[queue] < 1){
                quantityStack.remove(at: queue)
            }
        }
        BucketCollectionView.reloadData() // you do have an outlet of tableView I assume
    }
    
}


