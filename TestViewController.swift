//
//  ViewController.swift
//  Data Relationships
//
//  Created by Andrew Fenner on 8/10/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import UIKit
import CoreData
import Foundation


// Styles


// UI Elements

// var vcWeGoToMarblesBtn = UIButton()
// var vcWeGoToGameBtn = UIButton()
// var vcWeGoToGridBtn = UIButton()

var NumberShape: _numbershape!


let vline = UIView()

var vcTeBackBtn = UIButton()

class TestViewController: UIViewController
{
    
    func segueToGame(sender: UIButton)
    {
        
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "GameViewController")
        
        self.show(vc as! UIViewController, sender: vc)
        
    }
    
    
    func segueToMarbles(sender: UIButton)
    {
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "MarbleViewController")
        
        self.show(vc as! UIViewController, sender: vc)
        
    }
    
    func segueToGrid(sender: UIButton)
    {
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "GridViewController")
        
        self.show(vc as! UIViewController, sender: vc)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        

     
        NumberShape = _numbershape(view: view)
        
        // NumberShape.drawTwoDigits(firstDigit: 3, secondDigit: 3, at: view.center, ofSize: CGSize(width: 50,height: 50) , withImage: PinkBall)

        
        NumberShape.drawSingleDigit(number: 3, at: view.center, ofSize: CGSize(width: 50,height: 50) , withImage: PinkBall)

        
        view.addSubview(vcTeBackBtn)
        vcTeBackBtn.frame.styleBackBtn(view.frame)
        vcTeBackBtn.styleArrowBack()
        
        /* Add the background
        view.addSubview(BackGround)
        BackGround.image = UIImage(named: "Clouds")
        BackGround.frame.styleFillContainer(container: view.frame)
        
        
        
        // Set Up Buttons
        
        // Marble Button
        view.addSubview(vcWeGoToMarblesBtn)
        vcWeGoToMarblesBtn.frame.styleGoToMarbles(container: thisContainer)
        vcWeGoToMarblesBtn.styleChalkRect(text: "Marbles")
        
        // Game Button
        view.addSubview(vcWeGoToGameBtn)
        vcWeGoToGameBtn.frame.styleGoToGame(container: thisContainer)
        vcWeGoToGameBtn.styleChalkRect(text: "Game")
        
        // Grid Button
        view.addSubview(vcWeGoToGridBtn)
        vcWeGoToGridBtn.frame.styleGoToGrid(container: thisContainer)
        vcWeGoToGridBtn.styleChalkRect(text: "Grid")
        
        */
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

