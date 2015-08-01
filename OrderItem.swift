//
//  OrderItem.swift
//  SAProject
//
//  Created by 李昱賢 on 2015/6/11.
//  Copyright (c) 2015年 李昱賢. All rights reserved.
//

import Foundation
import CoreData

@objc(OrderItem)
class OrderItem: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var price: NSNumber
    @NSManaged var amount: NSNumber

}
