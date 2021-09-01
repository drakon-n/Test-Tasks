//
//  GoodCell.swift
//  test_shop
//
//  Created by Влад on 27.08.2021.
//

import UIKit
import CoreData


protocol BasketStateUpdater: AnyObject {
    func updateBasketState(state:Bool, index: Int)
}
class GoodCell: UICollectionViewCell {

    @IBOutlet weak var GoodImage: UIImageView!
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var goodPrice: UILabel!
    @IBOutlet weak var goodRate: UILabel!
    @IBOutlet weak var finalPrice: UILabel!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var goodDescription: UILabel!
    weak var delegate: BasketStateUpdater?
    var isOnBasket:Bool = false
    var identifier: String = ""
    var inBaseNumber = 0
    var index:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.GoodImage.image = nil
    }
    @IBAction func basketTouch(_ sender: Any) {
        if isOnBasket {
            isOnBasket = false
            basketButton.setTitle("В корзину", for: .normal) //лучше поменять на картинку корзины с подсветкой
            basketButton.setTitleColor(UIColor.systemBlue, for: .normal)
            
            UserDefaults.standard.set(isOnBasket, forKey: identifier)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(basketData[inBaseNumber])
            do{
                try context.save()
                basketData.remove(at: inBaseNumber)
            } catch let error as NSError {
                print("Failed to save \(error)")
            }
            
            
        }
        else
        {
            isOnBasket = true
            basketButton.isEnabled = false //я не придумал как удалять товары из корзины в правильном порядке, без громоздкого поиска в кор дате
            ChangeBasketState(state: isOnBasket)
            basketButton.setTitle("В корзине", for: .normal)
            basketButton.setTitleColor(UIColor.systemGreen, for: .normal)
            
            
            UserDefaults.standard.set(isOnBasket, forKey: identifier)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Good", in: context)
            let newGood = NSManagedObject(entity: entity!, insertInto: context)
            newGood.setValue(self.goodName.text, forKey: "name")
            newGood.setValue(self.goodRate.text, forKey: "rate")
            newGood.setValue(self.goodDescription.text, forKey: "decription")
            newGood.setValue(self.goodPrice.text, forKey: "price")
            newGood.setValue(1, forKey: "isOnBasket")
            newGood.setValue(1, forKey: "num")
            inBaseNumber = basketData.count-1
            let imageData = GoodImage.image?.pngData()
            newGood.setValue(imageData, forKey: "image")
            do{
                try context.save()
                basketData.append(newGood)
            } catch let error as NSError {
                print("Failed to save \(error)")
            }
        }
    }
    
    func setupCell(product:Product){
        self.GoodImage.image = product.image
        self.goodName.text = product.name
        self.goodPrice.text = String(describing: product.price) + " Руб/кг"
        self.goodDescription.text = product.description
        self.goodRate.text = String(describing: product.rate)
        self.finalPrice.text = String(describing: product.price) + "₽"
        
        if (isOnBasket){
            self.basketButton.setTitle("В корзине", for: .normal) //я не понимаю почему значения начинают мелькать на противоположные при обновлении коллекции
            self.basketButton.setTitleColor(.systemGreen, for: .normal)
            self.basketButton.isEnabled = false
        }
        else{
            self.basketButton.setTitle("В корзину", for: .normal)
            self.basketButton.setTitleColor(.systemBlue, for: .normal)
        }
    }
    
    func ChangeBasketState(state:Bool){
        delegate?.updateBasketState(state: state, index:self.index)
    }
}
