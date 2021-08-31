//
//  BucketCell.swift
//  test_shop
//
//  Created by Влад on 30.08.2021.
//

import UIKit

protocol CustomCellUpdater: AnyObject { // the name of the protocol you can put any
    func updateTableView(price: Float, isIncrement:Bool, queue:Int)
}

class BucketCell: UICollectionViewCell {   //опечатка в названии конечно

    @IBOutlet weak var basketImage: UIImageView!
    
    @IBOutlet weak var BasketName: UILabel!
    @IBOutlet weak var numberGoods: UILabel!
    @IBOutlet weak var basketPrice: UILabel!
    @IBOutlet weak var finalBasketPrice: UILabel!
    var stackNumber = 0
    var price: String = ""
    var number = 1
    weak var delegate: CustomCellUpdater?

    func updatePrice (modifier: Float, isIncrement:Bool) {
        delegate?.updateTableView(price: modifier, isIncrement: isIncrement, queue: stackNumber )
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func plusNumber(_ sender: Any) {
        print(stackNumber)
        if (number<99){
            //number = number + 1
        }
        //numberGoods.text = String(number)
        updatePrice(modifier: Float(price) ?? 0, isIncrement: true)
        updateFinalPrice()
    }
    
    @IBAction func minusNumber(_ sender: Any) {
        if(number>1){
            //number = number - 1
        }
        else{
            //number = number - 1
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(basketData[stackNumber])
            do{
                try context.save()
                basketData.remove(at: stackNumber)
            } catch let error as NSError {
                print("Failed to save \(error)")
            }
            
        }
        print("number??", number)
        //numberGoods.text = String(number)
        updatePrice(modifier: 0 - (Float(price) ?? 0), isIncrement: false)
        updateFinalPrice()
    }
    
    func updateFinalPrice(){
        finalBasketPrice.text = String(Float(price)! * Float(numberGoods.text!)!)
    }
    
}
