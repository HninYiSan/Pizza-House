//
//  WelcomeViewController.swift
//  PizzaSampleApp
//
//  Created by Hnin Yi on 8/19/19.
//  Copyright © 2019 Hnin Yi San. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBAction func gotoHome(_ sender: UIButton) {
        performSegue(withIdentifier: "homesegue", sender: nil)
    }
    
    var dbm:SQLiteDB = SQLiteDB.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
      dbm.open()
//        let cmd = "CREATE TABLE booking (bid INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,custname TEXT NOT NULL,custphno TEXT NOT NULL,datetime TEXT,peopleno INTEGER NOT NULL,foodOrder TEXT)"
//        dbm.query(sql: cmd)
//        print("success create")
//        dbm.closeDB()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)
    }
}
