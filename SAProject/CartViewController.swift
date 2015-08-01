//
//  CartViewController.swift
//  SAProject
//
//  Created by 李昱賢 on 2015/6/10.
//  Copyright (c) 2015年 李昱賢. All rights reserved.
//

import UIKit
import CoreData

class CartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var cart = []

    @IBOutlet weak var cartTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartTable.dataSource = self
        self.cartTable.delegate = self
        // Do any additional setup after loading the view.
        loadData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadData", name: NSManagedObjectContextDidSaveNotification, object: nil)
    }
    func loadData(){
        // 取得 Context
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context = appDelegate.managedObjectContext!
        
        // 建立查詢目標
        var fetch = NSFetchRequest(entityName: "OrderItem")
        
        // 執行查詢
        var error: NSError?
        var request = context.executeFetchRequest(fetch, error: &error)
        
        // 將查詢結果 存入 data source
        if let result = request {
            self.cart = result
            print(cart.count)
            self.cartTable.reloadData()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CartCell", forIndexPath: indexPath) as! UITableViewCell
        var orderitem = cart[indexPath.row] as! OrderItem
        cell.textLabel?.text = (orderitem.name + " : $" + orderitem.price.description + " : " + orderitem.amount.description)
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            var orderItem = self.cart[indexPath.row] as! OrderItem
            
            // 取得 Context
            var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            var context = appDelegate.managedObjectContext!
            
            // 刪除 todoItem
            context.deleteObject(orderItem)
            appDelegate.saveContext()
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
