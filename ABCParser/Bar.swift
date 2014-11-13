//
//  Bar.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/11/04.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation
import UIKit



class Bar:MusicalSymbol{
    let type:String
    init(bar:String){
        type = bar
    }
    
    override func render(x: Int, y: Int) {
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(CGFloat(x), CGFloat(y)))
        path.addLineToPoint(CGPointMake(CGFloat(x), CGFloat(y+40)))
        UIColor.blackColor().setStroke()
        path.lineWidth = 1
        path.stroke()
    }
}