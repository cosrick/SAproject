//
//  ViewController.swift
//  SAProject
//
//  Created by 李昱賢 on 2015/6/10.
//  Copyright (c) 2015年 李昱賢. All rights reserved.
//

import UIKit
import Parse
import AKPickerView_Swift

class ViewController: UIViewController , UITableViewDataSource,UITableViewDelegate , AKPickerViewDataSource, AKPickerViewDelegate{

    @IBOutlet weak var menuTable: UITableView!
    
    var array = [menuitem]()
    var picker = ["健身養生","優惠推薦","最夯推薦","節慶好禮","送禮佳品"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var query = PFQuery(className:"Menu")
        query.orderByAscending("Name")
        query.findObjectsInBackgroundWithBlock{ (objects,error) -> Void in
            if error == nil {
                for object in objects as [AnyObject]! {
                    var newitem = menuitem()
                    newitem.ProductName = object["Name"] as! String
                    newitem.ProductPrice = object["Price"] as! Float
                    self.array.append(newitem)
                    self.menuTable.reloadData()
                }
            }
        }
        self.menuTable.dataSource = self
        self.menuTable.delegate = self
        self.menuTable.tableFooterView = UIView(frame: CGRectZero)
        
        //Register Table Cell
        var nib = UINib(nibName: "CustomCell", bundle: nil)
        menuTable.registerNib(nib, forCellReuseIdentifier: "cell")
        var pickerview = AKPickerView(frame: CGRectMake(0, self.navigationController!.navigationBar.frame.height, self.view.frame.width, 10))
        self.view.addSubview(pickerview)
        pickerview.dataSource = self
        pickerview.delegate = self
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDetail"{
            var detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.Menuitem = sender as? menuitem
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.menuTable.dequeueReusableCellWithIdentifier("cell") as! TableViewCell
        cell.name.text = array[indexPath.row].ProductName
        cell.price.text = "$" + array[indexPath.row].ProductPrice.description
        cell.productimage.image = UIImage(named: "Rick")
        cell.DetailBtn.tag = indexPath.row
        cell.DetailBtn.addTarget(self, action: "Goto:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = array[indexPath.row] as menuitem
        self.performSegueWithIdentifier("toDetail", sender: item)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    func Goto(sender: UIButton){
        let item = array[sender.tag] as menuitem
        self.performSegueWithIdentifier("toDetail", sender: item)
    }
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return picker.count
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        println(item)
        return picker[item]
    }
    


}

