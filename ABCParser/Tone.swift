//
//  Tone.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/10/28.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation


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
    
    
    func updateLength(length:String){
        self.length = self.parseLength(length)
    }
    func parseLength(len:String) -> Fraction{
        
        return Fraction(stringFraction: len)
    }
}
