//
//  Fraction.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/11/05.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation

class Fraction{
    let numerator:Int
    let denominator:Int
    init(numerator:Int, denominator:Int){
        self.numerator = numerator
        self.denominator = denominator
    }
    init(stringFraction:String){
        var buf:String = ""
        var hasDenominator = false
        var numerator = 1
        var denominator = 1
        for bufChar in stringFraction{
            let char = String(bufChar)
            if char == "/"{
                numerator = buf.toInt()!
                buf = ""
                hasDenominator = true
            }
            else{
                buf += char
            }
        }
        if(hasDenominator){
            denominator = buf.toInt()!
        }
        else{
            numerator = buf.toInt()!
            denominator = 1
        }
        
        self.numerator = numerator
        self.denominator = denominator
        
        
    }
    
    
    func findHCF() -> Int {
        for var i=max(numerator, denominator); i>=1; i-- {
            if numerator % i == 0 && denominator % i == 0 {
                return i
            }
        }
        return 1
    }

    
}