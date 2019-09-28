//
//  PizzaViewController.swift
//  PizzaSampleApp
//
//  Created by Hnin Yi on 8/24/19.
//  Copyright © 2019 Hnin Yi San. All rights reserved.
//

import UIKit

class PizzaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var foodtype:String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    var fooddatas = [FoodData]()
    var foodqty = [(tag:Int,fid:Int,qty:Int)]()
    let dbm:SQLiteDB = SQLiteDB.shared
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fooddatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentfood = fooddatas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell", for: indexPath ) as? dataTableViewCell
        cell?.foodnameLabel.text = currentfood.foodname
        cell?.foodpriceLabel.text = String(currentfood.foodprice)
        cell?.promoLabel.text = "Dis: " + String(currentfood.foodpromo) + "%"
        cell?.qtyTextField.tag = indexPath.row
        cell?.qtyTextField.delegate = self
        return cell!
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        var qty:Int = Int(textField.text ?? "0") ?? 0
        var tagqty = (tag:textField.tag,fid:fooddatas[textField.tag].id,qty:qty)
        foodqty.append(tagqty)
        print(textField.tag)
        print(textField.text)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fooddatas.count > 0 ? ( view.frame.size.height / 10) : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Food Menu - '\(foodtype)' "
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }

    @IBAction func tagView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func order(_ sender: UIButton) {
    print("//////",foodqty[0].tag,foodqty[0].fid,foodqty[0].qty,foodqty.count)
        //if let sendfoodqty:[(tag:Int,qty:Int)] = foodqty {
            print("before send",foodqty.count)
           performSegue(withIdentifier: "ordersegue", sender: foodqty)
       // self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ordersegue" {
            let sendfoodqty:[(tag:Int,fid:Int,qty:Int)] = sender as! [(tag:Int,fid:Int,qty:Int)]
            let sendVC = segue.destination as! OrderViewController
            sendVC.foodqty = sendfoodqty
        }
    }
    
    func getData() {
        dbm.open()
        var cmd = "Select * from foodmenu where foodtype = '\(foodtype)'"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        print("food type",foodtype)
        getData()
    }
}
