//
//  Score.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/10/28.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation

class Score{
    var tempo = "Moderate"
    var key = "G"
    var title = ""
    var rows = [[MusicalSymbol]]()
    var length = Fraction(num: 1)
    var meter = "4/4"

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
