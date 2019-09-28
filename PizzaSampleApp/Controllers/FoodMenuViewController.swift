//
//  FoodMenuViewController.swift
//  PizzaSampleApp
//
//  Created by Hnin Yi on 8/19/19.
//  Copyright © 2019 Hnin Yi San. All rights reserved.
//

import UIKit

class FoodMenuViewController: UIViewController {

    @IBAction func chooseFoodMenu(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            performSegue(withIdentifier: "pizzasegue", sender: "pizza")
        case 1:
            performSegue(withIdentifier: "pizzasegue", sender: "pasta")
        case 2:
            performSegue(withIdentifier: "pizzasegue", sender: "salad")
        case 3:
            performSegue(withIdentifier: "pizzasegue", sender: "appetizer")
        case 4:
            performSegue(withIdentifier: "pizzasegue", sender: "drink")
        default:
            print("Error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pizzasegue" {
            let sendfoodtype:String = sender as! String
            let sendVC = segue.destination as! PizzaViewController
            sendVC.foodtype = sendfoodtype
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
