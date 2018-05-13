//
//  Item.swift
//  Todoey
//
//  Created by Vadim Gojan on 5/8/18.
//  Copyright © 2018 Vadim Gojan. All rights reserved.
//

import Foundation
// 14 cream o clasa noua pentru a structura datele(pentru ca checkmark sa fie legat de ceea ce este in celula sin nu de celula propriu zisa)

class Item: Codable {
    
    var title: String = ""
    
    var done: Bool = false
    
}



