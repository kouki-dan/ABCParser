//
//  Score.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/10/28.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation

class Score{
    var tempo = 120
    var key = "C"
    var tones = [] as [Tone]
    var rows = [[MusicalSymbol]]()
    
    
    
    func addRow(symbols:[MusicalSymbol]){
        rows.append(symbols)
    }
    
}
