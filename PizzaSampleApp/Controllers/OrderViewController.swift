//
//  OrderViewController.swift
//  PizzaSampleApp
//
//  Created by Hnin Yi on 8/28/19.
//  Copyright © 2019 Hnin Yi San. All rights reserved.

import UIKit

class OrderViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var foodqty : [(tag:Int,fid:Int,qty:Int)] = []
    let dbm:SQLiteDB = SQLiteDB.shared
    var existtbno = ["1","2","3","4","5","6","7","8","9"]
    var existcashier = ["Aung Ko","Maw Maw","Kyaw Nyi","Aye Su","Tun Min","Chaw Su","Myo Kyaw"]
    var selecttbno = "1"
    var selectcashier = "Aung Ko"
    var deli = "YES"
    var qty:Int = 0
    var amt:Int = 0
    var ofid:String = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableno: UIPickerView!
    @IBOutlet weak var cashier:UIPickerView!
    @IBOutlet weak var totqty: UITextField!
    @IBOutlet weak var totamt: UITextField!
    
    @IBAction func chooseDeli(_ sender: UISwitch) {
        if(sender.isOn)
        {
            deli = "YES"
        }
        else{
            deli = "NO"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == tableno {
            return existtbno.count
        }
        else if pickerView == cashier {
            return existcashier.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == tableno {
            return existtbno[row]
        }
        else if pickerView == cashier {
            return existcashier[row]
        }
        else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == tableno {
            selecttbno = existtbno[tableno.selectedRow(inComponent: 0)]
        }
        else if pickerView == cashier {
        selectcashier = existcashier[cashier.selectedRow(inComponent: 0)]
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodqty.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        let currentfood = foodqty[indexPath.row]
        dbm.open()
        let cmd = "Select * from foodmenu where fid = \(currentfood.fid)"
        let rows = dbm.query(sql: cmd)
        dbm.closeDB()
            let fid = rows[0]["fid"] as! Int
            let fname = rows[0]["foodname"] as! String
            let fprice = rows[0]["price"] as! Int
            let fpromo = rows[0]["promotion"] as! Int
            ofid += String(fid) + "-"
            qty += currentfood.qty
        let curpirce = fprice * currentfood.qty
        let promo = (curpirce * fpromo) / 100
        let promoprice = curpirce - promo
            amt += promoprice
        
        cell?.textLabel?.text = "\(fname) \t Total Price:\(promoprice)"
        cell?.detailTextLabel?.text = "Item Price: \(fprice) -- Discount: (\(fpromo)%) -- Qty: \(currentfood.qty)"
      
        totqty.text = String(qty)
        totamt.text = String(amt)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "*_* *_* Please Check Items and Qty *_* *_*"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    @IBAction func saveOrder(_ sender: UIButton) {
        let tno = Int(selecttbno) ?? 0 as! Int // to change optional value
        let cashiername = selectcashier ?? existcashier[0] as! String
        let dateSec = Date.init(timeIntervalSince1970: Date().timeIntervalSince1970)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let datestring = dateFormatter.string(from: dateSec)
        print(datestring)
        
        dbm.open()
        let cmd = "insert into foodorder (odate,ofid,totqty,totamt,tableno,cashier,delivery) values('\(datestring)','\(ofid)',\(qty),\(amt),\(tno),'\(cashiername)','\(deli)')"
        dbm.execute(sql: cmd)
        print("success insert")
        dbm.closeDB()
        HomeViewController.noticount += 1
        self.navigationController?.dismiss(animated: true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableno.dataSource = self
        tableno.delegate = self
        cashier.delegate = self
        cashier.dataSource = self
        totqty.isEnabled = false
        totamt.isEnabled = false
        print("In order",foodqty.count)
    }
}
