//
//  Tone.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/10/28.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation
import UIKit


class Tone : MusicalSymbol{
    var tone = "C"
    var length = Fraction(numerator: 1,denominator: 1)
    var sharp = false
    var natural = false
    var flat = false
    
    init(tone:String, length:String = "1"){
        super.init()
        self.tone = tone
        self.updateLength(length)
    }
    
    override func render(x: Int, y: Int) {
        let circle = UIBezierPath(ovalInRect: CGRectMake(CGFloat(x), CGFloat(y), 13, 9))
        UIColor.blackColor().setFill()
        
        let angle = -30.0 * M_PI / 180.0
        
        var move = CGAffineTransformMakeTranslation(CGFloat(-x), CGFloat(-y))
        let rotate = CGAffineTransformMakeRotation(CGFloat(angle))
        move = CGAffineTransformConcat(move, rotate)
        
        let move2 = CGAffineTransformMakeTranslation(CGFloat(x), CGFloat(y))
        move = CGAffineTransformConcat(move, move2)
        
        circle.applyTransform(move)
        circle.fill()
        
        let path = UIBezierPath()
        //path.moveToPoint(CGPointMake(CGFloat(x+10+4), CGFloat(y-1)))
        //path.addLineToPoint(CGPointMake(CGFloat(x+10+4), CGFloat(y+30)))
        path.moveToPoint(CGPointMake(CGFloat(x+2), CGFloat(y-1)))
        path.addLineToPoint(CGPointMake(CGFloat(x+2), CGFloat(y+30)))
        UIColor.blackColor().setStroke()
        path.lineWidth = 1
        path.stroke()
        
    }
    
    
    func updateLength(length:String){
        self.length = self.parseLength(length)
    }
    func parseLength(len:String) -> Fraction{
        
        return Fraction(stringFraction: len)
    }
}
