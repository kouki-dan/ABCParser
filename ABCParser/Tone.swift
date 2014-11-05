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
    var length = 1
    init(tone:String, length:String = "1"){
        self.tone = tone
        self.updateLength(length)
    }
    
    
    func updateLength(length:String){
        self.length = self.parseLength(length)
    }
    func parseLength(len:String) -> Int{
        //TODO: Implement!
        //len.split("/")
        for char in len{
            if char(
        }
        
        return 1
    }
}
