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
        "z":4,
        "Z":4,
    ]
    
    var length = Fraction(numerator: 1, denominator: 1)
    var sharp = false
    var natural = false
    var flat = false
    var renderPos:(x:CGFloat, y:CGFloat) = (0.0, 0.0)
    var direction:Bool!
    
    init(tone:String, length:String = "1", baseLength:Fraction = Fraction(num:1)){
        super.init()
        self.tone = tone
        self.updateLength(length, baseLength:baseLength)
    }
    
    func printRest(){
        
        
        if (self.length.graterThan(Fraction(numerator: 1, denominator: 1))) {
            //全休符
        }
        else if (self.length.graterThan(Fraction(numerator: 1, denominator: 2))) {
            //２分休符
        }
        else if (self.length.graterThan(Fraction(numerator: 1, denominator: 4))) {
            //4分休符(カラス)
            let path = UIBezierPath()
            let x = renderPos.x
            let y = renderPos.y

            path.moveToPoint(CGPointMake(CGFloat(x), CGFloat(y-10)))
            path.addLineToPoint(CGPointMake(CGFloat(x-3), CGFloat(y+24)))
            
            path.stroke()
 
            
            
            println("4分")
        }
        else if (self.length.graterThan(Fraction(numerator: 1, denominator: 8))) {
            //8分休符
            println("8分")
            let circle = UIBezierPath(ovalInRect: CGRectMake(renderPos.x, renderPos.y, 5, 5))
            circle.fill()
            
            let arc = UIBezierPath(arcCenter: CGPointMake(renderPos.x+6, renderPos.y), radius: 6, startAngle: 3.14, endAngle: 0, clockwise: false)
            arc.stroke()
            
            let path = UIBezierPath()
            let x = renderPos.x
            let y = renderPos.y
            path.moveToPoint(CGPointMake(CGFloat(x+12), CGFloat(y)))
            path.addLineToPoint(CGPointMake(CGFloat(x+6), CGFloat(y+24)))
            path.stroke()
            
            
 
        }
        else{
            println("are?")
        }

        
 

        
    }
    
    override func render(x: Int, y: Int) {
        UIColor.blackColor().setFill()
        UIColor.blackColor().setStroke()
        
        renderPos = calcRenderPos(x, y)
        
        if tone == "z" || tone == "Z"{
            printRest()
            return
        }
        
        
        let circle = UIBezierPath(ovalInRect: CGRectMake(renderPos.x, renderPos.y, 13, 9))
        
        let angle = -30.0 * M_PI / 180.0
        
        var move = CGAffineTransformMakeTranslation(-renderPos.x, -renderPos.y)
        let rotate = CGAffineTransformMakeRotation(CGFloat(angle))
        move = CGAffineTransformConcat(move, rotate)
        
        let move2 = CGAffineTransformMakeTranslation(renderPos.x, renderPos.y)
        move = CGAffineTransformConcat(move, move2)
        
        circle.applyTransform(move)
        
        println("\(self.length.numerator)/\(self.length.denominator)" )
        
        if self.length.graterThan(Fraction(numerator: 1, denominator: 2)) {
            circle.stroke()
        }
        else{
            circle.fill()
        }
        
        
        if(calcToneYPos() <= toneHeight*4){
            direction = false
        }
        else{
            direction = true
        }
        
        if (!self.length.graterThan(Fraction(numerator: 1, denominator: 1))) {
            if(calcToneYPos() <= toneHeight*4){
                renderPoll(direction)
            }
            else{
                renderPoll(direction)
            }
        }
        
        
        if(!self.length.graterThan(Fraction(numerator: 1, denominator: 4))){
            let path = UIBezierPath()
            let x = renderPos.x
            let y = renderPos.y
            if(direction == true){
                path.moveToPoint(CGPointMake(CGFloat(x+10+4), CGFloat(y-31)))
                path.addLineToPoint(CGPointMake(CGFloat(x+10+4+12), CGFloat(y-31+12)))
            }
            else{
                path.moveToPoint(CGPointMake(CGFloat(x+3), CGFloat(y+30)))
                path.addLineToPoint(CGPointMake(CGFloat(x+3+12), CGFloat(y+30+12)))
            }
            path.lineWidth = 1
            path.stroke()
        }
        
        if(self.sharp) {
            let path = UIBezierPath()
            let x = renderPos.x
            let y = renderPos.y
            
            path.moveToPoint(CGPointMake(CGFloat(x+17), CGFloat(y-2)))
            path.addLineToPoint(CGPointMake(CGFloat(x+17+12), CGFloat(y-2-2)))

            path.moveToPoint(CGPointMake(CGFloat(x+17), CGFloat(y+3)))
            path.addLineToPoint(CGPointMake(CGFloat(x+17+12), CGFloat(y+3-2)))
            
            path.moveToPoint(CGPointMake(CGFloat(x+19), CGFloat(y-6)))
            path.addLineToPoint(CGPointMake(CGFloat(x+19+1), CGFloat(y-6+12)))
            
            path.moveToPoint(CGPointMake(CGFloat(x+25), CGFloat(y-6-1)))
            path.addLineToPoint(CGPointMake(CGFloat(x+25+1), CGFloat(y-6+12-1)))


            path.lineWidth = 1
            path.stroke()
        }
        
        if(self.flat){
            let path = UIBezierPath()
            let x = renderPos.x
            let y = renderPos.y
 
            path.moveToPoint(CGPointMake(CGFloat(x+19), CGFloat(y+3-16)))
            path.addLineToPoint(CGPointMake(CGFloat(x+19), CGFloat(y+3)))
            
            //DOING
            //till
            path.lineWidth = 1
            path.stroke()
            
            
            let circle = UIBezierPath(ovalInRect: CGRectMake(x+19, y-6, 6, 10))
            circle.lineWidth = 1
            circle.stroke()
        }
        
        if(self.natural){
            let path = UIBezierPath()
            let x = renderPos.x
            let y = renderPos.y
            
            path.moveToPoint(CGPointMake(CGFloat(x+19), CGFloat(y-8)))
            path.addLineToPoint(CGPointMake(CGFloat(x+19+1), CGFloat(y-6+12)))
            path.addLineToPoint(CGPointMake(CGFloat(x+19+1+6), CGFloat(y-6+12-2)))
            
            path.moveToPoint(CGPointMake(CGFloat(x+19), CGFloat(y)))
            path.addLineToPoint(CGPointMake(CGFloat(x+25), CGFloat(y-1)))
            path.addLineToPoint(CGPointMake(CGFloat(x+25+1), CGFloat(y-6+18)))
            
            /*
            path.moveToPoint(CGPointMake(CGFloat(x+17), CGFloat(y-2)))
            path.addLineToPoint(CGPointMake(CGFloat(x+17+12), CGFloat(y-2-2)))
            
            path.moveToPoint(CGPointMake(CGFloat(x+17), CGFloat(y+3)))
            path.addLineToPoint(CGPointMake(CGFloat(x+17+12), CGFloat(y+3-2)))
            
*/
            path.lineWidth = 1
            path.stroke()
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
            path.moveToPoint(CGPointMake(CGFloat(x+2), CGFloat(y)))
            path.addLineToPoint(CGPointMake(CGFloat(x+2), CGFloat(y+30)))
        }
        path.lineWidth = 1
        path.stroke()
    }
    
    
    func updateLength(length:String, baseLength:Fraction = Fraction(num:1)){
        self.length = self.parseLength(length)
        self.length = self.length.times(baseLength)
    }
    func parseLength(len:String) -> Fraction{
        return Fraction(stringFraction: len)
    }
}
