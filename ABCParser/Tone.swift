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
    let heightTable = [
        "b":-3,
        "a":-2,
        "g":-1,
        "f":0,
        "e":1,
        "d":2,
        "c":3,
        "B":4,
        "A":5,
        "G":6,
        "F":7,
        "E":8,
        "D":9,
        "C":10,
    ]
    
    var length = Fraction(numerator: 1, denominator: 1)
    var sharp = false
    var natural = false
    var flat = false
    var renderPos:(x:CGFloat, y:CGFloat) = (0.0, 0.0)
    
    init(tone:String, length:String = "1"){
        super.init()
        self.tone = tone
        self.updateLength(length)
    }
    
    override func render(x: Int, y: Int) {
        UIColor.blackColor().setFill()
        UIColor.blackColor().setStroke()
        
        renderPos = calcRenderPos(x, y)
        
        let circle = UIBezierPath(ovalInRect: CGRectMake(renderPos.x, renderPos.y, 13, 9))
        
        let angle = -30.0 * M_PI / 180.0
        
        var move = CGAffineTransformMakeTranslation(-renderPos.x, -renderPos.y)
        let rotate = CGAffineTransformMakeRotation(CGFloat(angle))
        move = CGAffineTransformConcat(move, rotate)
        
        let move2 = CGAffineTransformMakeTranslation(renderPos.x, renderPos.y)
        move = CGAffineTransformConcat(move, move2)
        
        circle.applyTransform(move)
        circle.fill()
        
        
        if(true/* length bigger than 1/1 or not*/){
            if(calcToneYPos() <= toneHeight*4){
                renderPoll(false)
            }
            else{
                renderPoll(true)
            }
        }
        
    }
    
    func calcToneYPos()->Int{
        return toneHeight*heightTable[tone]!
    }
    
    func calcRenderPos(x:Int, _ y:Int)->(CGFloat, CGFloat){
        let newY = y + calcToneYPos()
        return (CGFloat(x), CGFloat(newY))
    }
    func renderPoll(direction:Bool){
        let path = UIBezierPath()
        let x = renderPos.x
        let y = renderPos.y
        if(direction){
            path.moveToPoint(CGPointMake(CGFloat(x+10+4), CGFloat(y-1)))
            path.addLineToPoint(CGPointMake(CGFloat(x+10+4), CGFloat(y-31)))
        }
        else{
            path.moveToPoint(CGPointMake(CGFloat(x+3), CGFloat(y-1)))
            path.addLineToPoint(CGPointMake(CGFloat(x+3), CGFloat(y+30)))
        }
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
