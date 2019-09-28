//
//  PromotionViewController.swift
//  PizzaSampleApp
//
//  Created by Hnin Yi on 9/2/19.
//  Copyright © 2019 Hnin Yi San. All rights reserved.
//

import UIKit

class PromotionViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var fooddatas = [FoodData]()
    let dbm:SQLiteDB = SQLiteDB.shared
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fooddatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentfood = fooddatas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
        cell?.textLabel?.text = "FoodName: \(currentfood.foodname)"
        cell?.detailTextLabel?.text = "Price: \(currentfood.foodprice) -- Promotion: \(currentfood.foodpromo)"
        return cell!
    }
    
    func getData() {
        dbm.open()
        var cmd = "Select * from foodmenu where promotion > 0 order by promotion desc"
        let rows = dbm.query(sql: cmd)
        dbm.closeDB()
        print(rows.count)
        for row in rows {
            let fid = row["fid"] as! Int
            let fname = row["foodname"] as! String
            let fprice = row["price"] as! Int
            let fpromo = row["promotion"] as! Int
            // print(fname)
            let fd = FoodData(id: fid, foodname: fname , foodprice:fprice , foodpromo: fpromo)
            // print(fd.foodname)
            fooddatas.append(fd)
            // print(fooddatas.count)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "*_* *_* Promotion Food Menu *_* *_*"
    }
    
    @IBAction func backtoHome(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
}
