//
//  HomeViewController.swift
//  PizzaSampleApp
//
//  Created by Hnin Yi on 8/19/19.
//  Copyright © 2019 Hnin Yi San. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    public static var noticount:Int = 0
    @IBOutlet weak var notiCountLabel: UILabel!
    
    @IBAction func chooseProcess(_ sender: UIButton) {
        print("noti value",HomeViewController.noticount)
        switch sender.tag {
        case 0:
            performSegue(withIdentifier: "foodmenusegue", sender: nil)
        case 1:
            performSegue(withIdentifier: "bookingsegue", sender: nil)
        case 2:
            performSegue(withIdentifier: "notisegue", sender: nil)
        case 3:
            performSegue(withIdentifier: "promotionsegue", sender: nil)
        case 4:
            performSegue(withIdentifier: "aboutsegue", sender: nil)
        default:
            print("error process")
        }
       // self.dismiss(animated: true, completion: nil)
       // print("Home bthn noti",HomeViewController.noticount)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       print("Home bthn noti",HomeViewController.noticount)
        if (HomeViewController.noticount == 0)
        {
          notiCountLabel.text = String(" ")
        }
        else {
            notiCountLabel.text = String(HomeViewController.noticount)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            notiCountLabel.text = String(" ")
    }

}
