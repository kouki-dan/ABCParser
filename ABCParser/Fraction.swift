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
    init(num:Int){
        self.numerator = num
        self.denominator = 1
    }
    init(numerator:Int, denominator:Int){
        self.numerator = numerator
        self.denominator = denominator
        
        let hcf = self.findHCF()
        self.numerator /= hcf
        self.denominator /= hcf
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
    
    func graterThan(that:Fraction) -> Bool {
        return Double(self.numerator) / Double(self.denominator) >= Double(that.numerator) / Double(that.denominator)
    }

    func times(right: Fraction) -> Fraction {
        let numerator = self.numerator * right.numerator
        let denomitor = self.denominator * right.denominator
    
        return Fraction(numerator: numerator, denominator: denomitor)
    }

    func minus(right:Fraction) -> Fraction {
        let numerator = self.numerator * right.denominator - right.numerator * self.denominator
        let denominator = self.denominator * right.denominator
        
        return Fraction(numerator: numerator, denominator: denominator)
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