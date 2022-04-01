//
//  list_info.swift
//  HW1
//
//  Created by 朱雨珂 on 2022/3/26.
//

import Foundation
import Swift
import SwiftUI

struct list_info:Identifiable{
    var id=UUID()
    
    var list_color:Color
    var list_name:String
    var list_num:Int
    var chosen:Bool
    
    var details:[detail_info]
    
}
struct detail_info:Identifiable{
    var id=UUID()
    
    var date:Date
    var time:Date
    var location:String
    //var repeating: String
    var priority:String
    var title:String
    var note:String
    
}

struct location_item:Identifiable,Equatable,Hashable{
    var id=UUID()
    var text:String
    var content:String
    var image:String
    var color:Color
}

struct reminder_popitem:Identifiable{
    var id = UUID()
    var image:String
    var content:String
}

