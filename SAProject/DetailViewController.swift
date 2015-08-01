//
//  DetailViewController.swift
//  SAProject
//
//  Created by 李昱賢 on 2015/6/10.
//  Copyright (c) 2015年 李昱賢. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    var Menuitem: menuitem!
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var Account: UILabel!
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductImage.image = UIImage(named: "Rick")
        ProductName.text = Menuitem?.ProductName
        Account.text = num.description
        
        self.title = Menuitem?.ProductName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Add(sender: AnyObject) {
        num++
        Account.text = num.description
    }
    @IBAction func minus(sender: AnyObject) {
        if num == 0{
            let myalert = UIAlertController(title: "警告", message: "訂購數量不可以小於0", preferredStyle: UIAlertControllerStyle.Alert)
            myalert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(myalert, animated: true, completion: nil)
        }else{
            num--
            Account.text = num.description
        }
    }
    
    @IBAction func Order(sender: AnyObject) {
        if num == 0{
            let myalert = UIAlertController(title: "警告", message: "訂購數量不可以為0", preferredStyle: UIAlertControllerStyle.Alert)
            myalert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(myalert, animated: true, completion: nil)
        }else{
            // 取得 Context
            var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            var context = appDelegate.managedObjectContext!
            
            // 建立 Entity
            var orderItem = NSEntityDescription.insertNewObjectForEntityForName("OrderItem", inManagedObjectContext: context) as! OrderItem
            
            orderItem.name = Menuitem.ProductName
            orderItem.price = Menuitem.ProductPrice
            orderItem.amount = num
            // 儲存 Todo項目
            appDelegate.saveContext()
            
            self.navigationController?.popViewControllerAnimated(true)
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
