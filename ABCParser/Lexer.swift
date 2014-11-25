//
//  Lexer.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/11/05.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation

class Lexer{
    let toneSymbols = "^=_abcdefgABCDEFGzZ"
    let lengthSymbols = "1234567890/"
    let musicalSymbols = "|:"
    var string:String
    let baseLength:Fraction
    init(string:String, baseLength:Fraction = Fraction(num: 1)){
        self.string = string
        self.baseLength = baseLength
    }
    
    func predictSymbol(row:[Character],symbols:String, nowPos:Int) -> String{
        var i = 1;
        var retToken = String(row[nowPos])
        while(nowPos+i < row.count){
            let nextChar = String(row[nowPos+i])
            if symbols.has(nextChar){
                retToken += nextChar
                i += 1
            }
            else{
                i -= 1
                break
            }
        }
        return retToken
        
    }
    
    func lex() -> [MusicalSymbol]{
        var score = [MusicalSymbol]()
        
        var row = Array(string)
        for(var i = 0; i < row.count; i++) {
            let char = String(row[i])
            if(toneSymbols.has(char)) {
                //TODO: Implement sharp and flat and natural
                /*The symbols ^, = and _ are used (before a note) to notate respectively a sharp, natural or flat. Double sharps and flats are available with ^^ and __ respectively. */
                let token = predictSymbol(row, symbols: toneSymbols, nowPos: i)
                i += Array(token).count - 1;
                
                let tone = Tone(tone:String(Array(token).last!), baseLength:baseLength)
                if token.hasPrefix("^"){
                    //sharp
                    tone.sharp = true
                }
                else if token.hasPrefix("="){
                    //natural
                    tone.natural = true
                }
                else if token.hasPrefix("_"){
                    //flat
                    tone.flat = true
                }
                score.append(tone)
                
            }
            else if (musicalSymbols.has(char)){
                let token = predictSymbol(row, symbols: musicalSymbols, nowPos: i)
                i += Array(token).count - 1;
                
                score.append(Bar(bar: token))
            }
            else if (lengthSymbols.has(char)){
                let token = predictSymbol(row, symbols: lengthSymbols, nowPos: i)
                i += Array(token).count - 1;
                
                //TODO:
                let lastTone = score[score.count-1] as Tone
                if( /* lastTone is really tone? */ true){
                    lastTone.updateLength(token, baseLength:baseLength)
                }
                
            }
        }
        
        return score
    }
    
}