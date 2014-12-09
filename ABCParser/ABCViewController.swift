//
//  ViewController.swift
//  ABCParser
//
//  Created by Kouki Saito on 2014/10/28.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//

import UIKit

class ABCViewController: UIViewController {

    @IBOutlet weak var scoreView: ScoreView!
    var tones:[Tone] = []
    var nowIndex = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        tones = scoreView.score.getAllTones()
        
    }
    
    @IBAction func nextTone(sender: AnyObject) {
        if nowIndex >= 1 {
            tones[nowIndex-1].selected = false
        }
        
        if nowIndex == tones.count {
            //return true
        }
        
        tones[nowIndex].selected = true
        
        nowIndex += 1
        self.scoreView.render()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

