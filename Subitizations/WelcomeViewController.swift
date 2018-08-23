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


// Properties
let vcWeActivities = 2


// Styles
extension CGRect
{
    
    mutating func styleGoToMarbles(container: CGRect) {
        
        let w = container.width/2
        let h = w/5
        let x = container.width/2 - w/2
        let y = container.height/4 + h
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
    }
    
    mutating func styleGoToGame(container: CGRect) {
        
        let w = container.width/2
        let h = w/5
        let x = container.width/2 - w/2
        let y = container.height/4 + 2*h
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
    }
    
    mutating func styleGoToGrid(container: CGRect) {
        
        let w = container.width/4
        let h = w/5
        let x = container.width/2 - w/2
        let y = container.height/4 + 2*h
        
        self = CGRect(x: x, y: y, width: w, height: h)
        
    }
    
}

// UI Elements

var vcWeGoToMarblesBtn = UIButton()
var vcWeGoToGameBtn = UIButton()
var vcWeGoToGridBtn = UIButton()


class WelcomeViewController: UIViewController
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

        let thisContainer = view.frame
        
        // Add the background   
        view.addSubview(BackGround)
        BackGround.image = UIImage(named: "Clouds")
        BackGround.frame.styleFillContainer(container: view.frame)
        

        
        // Set Up Buttons
        
        // Marble Button
        view.addSubview(vcWeGoToMarblesBtn)
        vcWeGoToMarblesBtn.frame.styleGoToMarbles(container: thisContainer)
        vcWeGoToMarblesBtn.styleChalkRect(text: "Discover")
       
        // Game Button
        view.addSubview(vcWeGoToGameBtn)
        vcWeGoToGameBtn.frame.styleGoToGame(container: thisContainer)
        vcWeGoToGameBtn.styleChalkRect(text: "Play")
   
        /* Grid Button
        view.addSubview(vcWeGoToGridBtn)
        vcWeGoToGridBtn.frame.styleGoToGrid(container: thisContainer)
        vcWeGoToGridBtn.styleChalkRect(text: "Grid")
         */
        
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        vcWeGoToMarblesBtn.addTarget(self, action: #selector(segueToMarbles(sender:)), for: .touchUpInside)
        vcWeGoToGameBtn.addTarget(self, action: #selector(segueToGame(sender:)), for: .touchUpInside)
        vcWeGoToGridBtn.addTarget(self, action: #selector(segueToGrid(sender:)), for: .touchUpInside)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

