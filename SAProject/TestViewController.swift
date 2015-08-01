//
//  TestViewController.swift
//  Pods
//
//  Created by 李昱賢 on 2015/6/14.
//
//

import UIKit
import AKPickerView_Swift

class TestViewController: UIViewController , AKPickerViewDataSource, AKPickerViewDelegate{
    var array = ["test1","test2","test3"]
    var pickerView = AKPickerView(frame: CGRectMake(0, 44, 375, 44))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.pickerViewStyle = AKPickerViewStyle.Flat
        
        self.view.addSubview(pickerView)
        self.pickerView.reloadData()
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return 3
    }
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        println(array[item])
        return array[item]
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
