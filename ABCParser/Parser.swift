//
//  parser.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/10/28.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import Foundation

class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        var error: NSError?
        self.internalExpression = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)
    }
    
    func test(input: String) -> Bool {
        let matches = self.internalExpression.matchesInString(input, options: nil, range:NSMakeRange(0, countElements(input)))
        return matches.count > 0
    }
}


extension String{
    subscript (i: Int) -> String {
        return String(Array(self)[i])
    }
    func has(that:String) -> Bool{
        let range = self.rangeOfString(that)
        if let t = range{
            return true
        }
        else{
            return false
        }
    }
}


class Parser{
    var abcScore:String
    
    var rows = [] as Array<String>
    var headers = Dictionary<String,String>()
    
    let headerTable = [
        "T":"Title",
        "M":"Meter",
        "L":"Length",
        "K":"Key",
    ]
    
    let toneSymbols = "abcdefgABCDEFG"
    let lengthSymbols = "1234567890/"
    let musicalSymbols = "|:"
    
    
    init(abcScore:String){
        self.abcScore = abcScore
        parse()
        
        
    }
    
    
    
    func parse() -> Score{
        let score = Score()
        
        let rows = split(self.abcScore, { $0 == "\n" })
            
        var i = 0;
        var headerNow = true
        
        
        while headerNow {
            let header = headerParse(rows[i++])
            if header.key == ""{
                headerNow = false
                i--;
            }
            else{
                headers.updateValue(header.val, forKey:header.key)
            }
        }
        
        while i < rows.count{
            //TODO
            var bodyLexer = Lexer(string: rows[i])
            
            bodyLexer.lex()
            
            

            
            //score.add(row)
            println(rows[i])
            
            i++
        }
        
        return score
    }
    
    
    func headerParse(header:String) -> (key:String, val:String){
        var idx: String.Index
        
        if !Regex("^[a-zA-Z]:.*$").test(header) {
            return ("","")
        }
       
        
        idx = advance(header.startIndex, 1)
        var key = header.substringToIndex(idx)
        if let k = headerTable[key]{
            key = k
        }
        
        idx = advance(header.startIndex, 2)
        var value = header.substringFromIndex(idx)
        
        return (key, value)
    }
    

    
    
}

