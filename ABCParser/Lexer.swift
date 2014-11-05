//
//  Lexer.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/11/05.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation

class Lexer{
    let toneSymbols = "abcdefgABCDEFG"
    let lengthSymbols = "1234567890/"
    let musicalSymbols = "|:"
    var string:String
    init(string:String){
        self.string = string
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
    
    func lex() -> String{
        var row = Array(string)
        for(var i = 0; i < row.count; i++) {
            let char = String(row[i])
            if(toneSymbols.has(char)) {
                println(char)
            }
            else if (musicalSymbols.has(char)){
                let token = predictSymbol(row, symbols: musicalSymbols, nowPos: i)
                
                i += Array(token).count - 1;
                println(token)
            }
            else if (lengthSymbols.has(char)){
                let token = predictSymbol(row, symbols: lengthSymbols, nowPos: i)
                
                println(token)
                i += Array(token).count - 1;
            }
        }
        return ""
    }
    
}