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
    
    let headerTable = [
        "T":"title",
        "M":"meter",
        "L":"length",
        "K":"key",
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
            if header.key == "" {
                headerNow = false
                i--;
            }
            else{
                switch header.key{
                    case "title":
                        score.setTitle(header.val)
                    case "length":
                        score.setLength(header.val)
                    case "key":
                        score.setKey(header.val)
                    case "meter":
                        score.setMeter(header.val)
                    default:
                        true;
                    
                }
            }
        }
        
        
        
        while i < rows.count{
            //TODO
            var bodyLexer = Lexer(string: rows[i])
            
            let scoreRow = bodyLexer.lex()
            score.addRow(scoreRow)
            
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

