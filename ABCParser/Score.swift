//
//  Score.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/10/28.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation
import UIKit

//prev 10 to toneHeight*2
let toneHeight = 5

class Score{
    var tempo = "Moderate"
    var key = "G"
    var title = ""
    var rows = [[MusicalSymbol]]()
    var length = Fraction(num: 1)
    var meter = "4/4"
    var targetView:UIView! = nil

    
    func render(targetView:UIView){
        self.targetView = targetView
        showScore()
    }

    func showScore(){
        let width = Int(UIScreen.mainScreen().bounds.width)
        
        for(var i = 0; i < rows.count; i++){
            showScoreBase(30 + i*70, width: width-20)
            
            putTones(rows[i], y: 30 + i*70, width: width-40)
        }
    }
    
    func putTones(symbols:[MusicalSymbol], y:Int, width:Int){
        let toneWidth = width / symbols.count
        
        var i = 0
        for symbol in symbols {
            symbol.render(40+i*toneWidth, y:y)
            i+=1
        }
        
    }
    
    
    func showScoreBase(y:Int,width:Int){
        showGclef(y)
        for(var i = 0; i < 5; i++){
            line(y+i*toneHeight*2, width: width)
        }
    }
    
    func showGclef(y:Int){
        let a = UIImageView(image: UIImage(named: "Gclef.png"))
        a.frame = CGRectMake(15, CGFloat(y-10), 20, 60)
        
        self.targetView.addSubview(a)
    }
    
    func line(y:Int, width:Int){
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(CGFloat(10), CGFloat(y)))
        path.addLineToPoint(CGPointMake(CGFloat(10+width), CGFloat(y)))
        UIColor.blackColor().setStroke()
        path.lineWidth = 1
        path.stroke()
    }
    
    
    func addRow(symbols:[MusicalSymbol]){
        rows.append(symbols)
    }

    func setTitle(title:String){
        self.title = title;
    }
    func setLength(length:String){
        self.length = Fraction(stringFraction: length)
    }
    func setKey(key:String){
        self.key = key;
    }
    func setMeter(meter:String){
        self.meter = meter
    }

}
