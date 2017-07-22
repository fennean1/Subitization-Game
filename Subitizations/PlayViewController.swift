//
//  ViewController.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/12/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var MixButton: UIButton!
    
    @IBAction func mixUpBalls(sender: UIButton){
        
         // let N = arc4random_uniform(9) + 1
        let N = 5
    
        Toggler += 1
        
        
        if Toggler%2 == 1
        {

            
            drawConfiguration(n: N, marbles: Marbles, at: view.center, marblesize: 50)
            
        }
        else {
           
            print("Move to shape")
            
            drawNumberShape(value: Int(N), at: view.center, side: 50, balls: Marbles, ballimage: PinkBall)
            
            
        }
 
        
    }
    
    
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
     
        
        view.addSubview(BackGround)
        BackGround.image = UIImage(named: "Clouds")
        BackGround.frame.styleBackGround(container: view.frame)

        

        initMarbles(n: 10)
        
        
        // Add the marbles to the superview
        for marble in Marbles{
            
            marble.frame.size = CGSize(width: 50, height: 50)
            view.addSubview(marble)
            
        }
        
        // Configuration.backgroundColor = UIColor.gray
        
        
        view.bringSubview(toFront: MixButton)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

