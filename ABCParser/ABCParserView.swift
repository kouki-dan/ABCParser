//
//  ABSParserView.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/10/28.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import UIKit

class ABCParserView: UIView {
    let parser:Parser
    required init(coder aDecoder: NSCoder) {
        
        let abcScore = "X:1\n" +
                       "T:きらきら星\n" +
                       "M:4/4\n" +
                       "L:1/4\n" +
                       "K:C\n" +
                       "C C G G | A A G2 | F F E E | D D C2 |\n" +
                       "||G G F F | E E D2 | G G F F | E E D2 |\n" +
                       "|: C C G G | A A G2 | F F E E | D D C2 :|\n" +
                       "|: C1/2 C1/2 C1/2 C1/2 G2 | A1/2 A1/2 A1/2 A1/2 G2 | F1/2 z1/2 F 1/2 z1/2 E E | D D C2 :|\n"

        parser = Parser(abcScore: abcScore)
        
        super.init(coder: aDecoder)
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
