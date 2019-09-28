//
//  NotificationViewController.swift
//  PizzaSampleApp
//
//  Created by Hnin Yi on 9/20/19.
//  Copyright © 2019 Hnin Yi San. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var dateTime: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    var foodorders:[[String:Any]] = []
    var dbm:SQLiteDB = SQLiteDB.shared
    var cmd = ""
    private var datestr = ""
    var titlename:String = ""
    
    @IBAction func viewOrder(_ sender: UIButton) {
        titlename = "*_* *_* Food Data by Order *_* *_*"
        foodorders.removeAll()
        cmd = "select * from foodorder where odate='\(datestr)' and delivery='NO'"
        getFoodData(cmd)
    }
    
    @IBAction func viewDelivery(_ sender: UIButton) {
         titlename = "*_* *_* Food Data by Delivery *_* *_*"
        print("date deli",datestr)
        foodorders.removeAll()
        cmd = "select * from foodorder where odate='\(datestr)' and delivery='YES'"
        getFoodData(cmd)
       
    }
    
    @IBAction func viewBooking(_ sender: UIButton) {
        titlename = "*_* *_* Booking Data *_* *_*"
        foodorders.removeAll()
        cmd = "select * from booking where datetime like '\(datestr)%'"
        dbm.open()
        let rows = dbm.query(sql: cmd)
        dbm.closeDB()
        print("total value cmd",rows.count)
        for row in rows {
            let custname = row["custname"] as! String
            let custphno = row["custphno"] as! String
            let datetime = row["datetime"] as! String
            let peopleno = row["peopleno"] as! Int
            let foodorder = row["foodOrder"] as! String
            let fd:[String:Any] = ["ftype":"booking","custname":custname,"custphno":custphno,"datetime":datetime,"peopleno":peopleno,"foodorder":foodorder] as [String : Any]
            // print("fd dict",fd)
            foodorders.append(fd)
        }
        print("booking count",foodorders.count)
        tableView.reloadData()
    }
    
    @IBAction func backToHome(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        self.datestr = dateFormatter.string(from: sender.date)
        print("choose date",self.datestr)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodorders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        let currentorder:[String:Any] = foodorders[indexPath.row]
        let ftype = currentorder["ftype"] as! String
      if( ftype == "order")
      {
        let ofid = currentorder["ofid"] as! String
        let totqty = currentorder["totqty"] as! Int
        let totamt = currentorder["totamt"] as! Int
        let tableno = currentorder["tableno"] as! Int
        let cashier = currentorder["cashier"] as! String
        cell?.textLabel?.text = "TableNo:\(tableno)  Qty:\(totqty)  Amount:\(totamt)"
        cell?.detailTextLabel?.text = "Food ID:[\(ofid)]  Cashier:\(cashier)"
        }
        else if(ftype == "booking")
        {
        let custname = currentorder["custname"] as! String
        let custphno = currentorder["custphno"] as! String
        let datetime = currentorder["datetime"] as! String
        let peopleno = currentorder["peopleno"] as! Int
        let foodorder = currentorder["foodorder"] as! String
        cell?.textLabel?.text = "Date: \(datetime)  People:\(peopleno)"
            cell?.detailTextLabel?.text = "Name:\(custname) Phone:\(custphno) Food Order:\(foodorder)"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(titlename)"
    }
    
    func getFoodData(_ cmd:String) {
        dbm.open()
        let rows = dbm.query(sql: cmd)
        dbm.closeDB()
        print("total value cmd",rows.count)
        for row in rows {
            let ofid = row["ofid"] as! String
            let totqty = row["totqty"] as! Int
            let totamt = row["totamt"] as! Int
            let tableno = row["tableno"] as! Int
            let cashier = row["cashier"] as! String
            let fd:[String:Any] = ["ftype":"order","ofid":ofid,"totqty":totqty,"totamt":totamt,"tableno":tableno,"cashier":cashier] as [String : Any]
            // print("fd dict",fd)
            foodorders.append(fd)
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        HomeViewController.noticount = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeViewController.noticount = 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        datestr = dateFormatter.string(from: Date())
        //datestr = "2019-09-20"
        cmd = "select * from foodorder where odate='\(datestr)' and delivery='NO'"
        titlename = "*_* *_* Food Data by Order *_* *_*"
        getFoodData(cmd)
    }
}
