//
//  BookingViewController.swift
//  PizzaSampleApp
//
//  Created by Hnin Yi on 8/19/19.
//  Copyright © 2019 Hnin Yi San. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {
    @IBOutlet weak var custName: UITextField!
    @IBOutlet weak var phno: UITextField!
    @IBOutlet weak var peopleno: UITextField!
    @IBOutlet weak var foodorder: UITextField!
    @IBOutlet weak var datedata: UIDatePicker!
    var datestr:String = ""
    var dbm:SQLiteDB = SQLiteDB.shared
    
    @IBAction func chooseDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm a"
        let dateString = dateFormatter.string(from: sender.date)
        datestr = dateString
        print(datestr)
    }
    
    @IBAction func bookNow(_ sender: UIButton) {
        let cname = custName.text as! String
        let phno = self.phno.text as! String
        let peopleno = Int(self.peopleno.text!) as! Int
        let foodorder = self.foodorder.text as! String
        dbm.open()
        let cmd = "insert into booking(custname,custphno,datetime,peopleno,foodOrder) values('\(cname)','\(phno)','\(datestr)',\(peopleno),'\(foodorder)')"
        dbm.execute(sql: cmd)
        print("Success booking")
        dbm.closeDB()
        HomeViewController.noticount += 1
    }

    @IBAction func tagView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datedata.minimumDate = Date()
    }
}
