//
//  ABSParserView.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/10/28.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import UIKit

class ABCParserView: UIView {
    var parser:Parser!
    var score:Score!
    var abcScore = "X:1\n" +
        "T:きらきら星\n" +
        "M:4/4\n" +
        "L:1/4\n" +
        "K:C\n" +
        "C C G G | A A G2 | F F E E | D D C2 |\n" +
        "||G G F F | E E D2 | G G F F | E E D2 |\n" +
        "|: C C G G | A A G2 | F F E E | D D C2 :|\n"
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        parser = Parser(abcScore: abcScore)
        score = parser.parse()
    }
    
    
    func parse(abcScore:String){
        parser = Parser(abcScore: abcScore)
        score = parser.parse()
    }
    
    func render(){
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        if self.score != nil {
            self.score.render(self)
        }
        //showScore()
    }
    

    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
