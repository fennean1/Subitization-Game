//
//  ViewController.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/12/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import UIKit

// --- UI elements local to the PlayViewController

var vcGaStartButton = UIButton()

var vcGaNextButton = UIButton()

var vcGaBackBtn = UIButton()

var vcGaDidInit = false

var ScoreLabel: UILabel!

var vcGaCounterImage = PinkBall

var vcGaMainMarble = BlueBall

var vcGaAccentMarble = OrangeBall

var dT: CGFloat = 0

var Cycler = 0

var GameOver = false

var CurrentLevel = Levels[0]

var Modal = modalview()

var CurrentPlayer: player!

var Attempts = 0

var Time: Double = 0

var TimeElapsed: Double = 0

// The number being presented.
var Argument = 0

// GameViewController Styles

// CGRect
extension CGRect {

mutating func styleCenterButton(container: CGRect) {
    
    
    let w = container.width/7
    let h = w/4
    
    let x = container.width/2 - w/2
    let y = container.height - container.width/4
    
    
    self = CGRect(x: x, y: y, width: w, height: h)
    
}

}

// UIButton



class GameViewController: UIViewController {

    
    
    
    
    var ResponseButtons: [responsebutton] = []

    
    var localTimer = Timer()
    
    var SubmissionTime: Double = 0
    
    
    
    
    
    func initResponseButtons(container: CGRect) {
        
        
        for _ in 1...10
        {
            
            let newButton = responsebutton(frame: container)
            
            ResponseButtons.append(newButton)
            
        }
        
        
    }
    

    
    
    func startGame(sender: UIButton)
    {
        for trophy in TrophyButtons
        {
            trophy.setImage(nil, for: .normal)
        }
        
        // Drawing the buttons (because they get rendered each turn.
        for (index,button) in ResponseButtons.enumerated()
        {
            button.drawNumber(n: index + 1)
        }
        
        // Create new player
        CurrentPlayer = player()
        CurrentPlayer.myCurrentLevel = Levels[0]
        CurrentPlayer.Playing = true
        CurrentPlayer.initPerformanceDataContext()
        Attempts = 0
        
        
        localTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
        
        _ = presentNewProblem()
    
        // Hide the start button
        hide(view: sender)
        
    }
    
    
    func vcGaReset() {
        
        
        
        
        
    }
    
    func goBack(sender: UIButton) {
        
        print("Resetting the game variables")

        dT = 0
        
        Cycler = 0
        
        GameOver = false
        
        CurrentLevel = Levels[0]
        
        Attempts = 0
        
        Time = 0
        
        Marbles = []
        
        TimeElapsed = 0
        
        centers = []
        
        ResponseButtons = []
        
        Argument = 0
        
        CurrentPlayer.Playing = false
        
        print("Going back to WelcomeViewController")
        
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "WelcomeViewController")
        
        self.show(vc as! UIViewController, sender: vc)
        
    }
    
    func presentNewProblem() -> Bool
    {
    
        // Returns zero if the current level is out of questions.
        print("Getting new problem from the current level...")
        print("Number of Problems Left = ",CurrentLevel.problemSet.count)
        
        
        // Returns zero if there are no more questions.
        Argument = pluckProblemFromCurrentLevel()
        

        // Present new problem exits and returns false if there are no more problems in the the level. NOTE: There may be a better way to detect the end of the game cycle.
        guard Argument != 0 else
        {
            
            return false
        }

     
        vcGaCounterImage = MainMarble

        // Player is currently 
        print("Player is currently solving a problem...")
        CurrentPlayer.Playing = true
        dT = 0
        
     
 

        
        drawConfiguration(value: Argument, at: view.center, marbles: Marbles, ballimage: MainMarble, marblesize: 50)
     
        
        Cycler += 1

        
        return true
        
    }
    
    func updateTimer()
    {
        
        if CurrentPlayer.Playing == true
        {
            dT = dT + 0.01
        }
        
        
    }
    
    
    func nextProblem(sender: UIButton)
    {
        
        // Check to see if presentNewProblem() returns true.
        guard presentNewProblem() == true else {
            
            // ENDING GAME
            print("presentNewProblem has returned false and the game is over.")
            CurrentPlayer.Playing = false
           
            
            // ACTION: Need to present the user with options on how to proceed once the game has concluded. Could use Modal defined in "Library"
            
            
            // Reset The level
           
            CurrentLevel = Levels[0]
            
            CurrentPlayer.initPerformanceDataContext()
            
            let earnedTrophy = trophy(percentage: Score/Normalizer)!
            
            Score = 0
            dT = 0
            
            
            // Need to re - write modal so it can handle next user action. 
            Modal.drop(earnedTrophy, messege: "Level \(CurrentPlayer.myCurrentLevel.index+1) Complete!")
            
            vcGaStartButton.frame.styleCenterButton(container: self.view.frame)
            
            return
            
        }
        
        CurrentPlayer.Playing = true
        
        hide(view: vcGaNextButton)
        
        ScoreLabel.text = "Total: \(Int(Score))"
        
    }
    
    
    func answerSubmit(sender: responsebutton) {
        
        
        
        // If the player isn't playing then nothing should happen when these buttons are pressed. We used the Bool "Playing" state so we don't have to disable each button everytime we don't want them to respond.
        guard CurrentPlayer.Playing == true else {
            
            
            print("Shouldn't be able to press me!")
            
            return
            
        }
        
        Attempts += 1
  
        // TimerLabel.text = "\(Int(60 - SubmissionTime))"

        ScoreLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
     
  
        let originalCenters = Marbles.map({$0.center})
        
        
       // Pushes an array of points outward from their collective center.
       let bouncedCenters = bouncePoints(points: originalCenters, center: self.view.center)
        
        // sender._n? why did I name that _n?
        if sender._n == Argument {
            
            Attempts = 0
            
            CurrentPlayer.Playing = false
            
            let score = calculateScore(dT: dT,number: Argument,attempts: Attempts)

            Score = Score + CGFloat(score)
            
            // Present feedback
            ScoreLabel.text = "\(Int(score)) Points!"
            
            print("The current level is",CurrentLevel.index)
            
            CurrentPlayer.updatePerfomanceDataFor(n: Argument, with: CGFloat(score))
            
            TrophyButtons[Argument-1].updateTrophy(percentage: CurrentPlayer.myPerformanceData[Argument-1].1/Normalizer)
            
            UIView.animate(withDuration: 0.4, animations: {ScoreLabel.frame.styleScoreLabel(container: self.view.frame)},completion: {finished in
                
            })
            
            
            // Present "Next" Button
            let _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(presentNextButton)), userInfo: nil, repeats: false)
            
            
            // Show the true shape
            drawNumberShape(value: Argument, at: view.center,marbles: Marbles, ballimage: vcGaCounterImage, marblesize: 50)
            
            
            
        }
        else {
            


            
            UIView.animate(withDuration: 0.3, animations: {
                
                for (j,m) in Marbles.enumerated()
                {
                    
                    m.center = bouncedCenters[j]
                    
                    
                    
                }
                
            },
            completion: {finished in
                

             
            UIView.animate(withDuration: 0.3, animations: {
                    
                    print("Animating to original centers",originalCenters)
                    
                    
                    for (i,m) in Marbles.enumerated()
                    {
                        m.center = originalCenters[i]
                    }
                    
                })
 

 
            })

 
            ScoreLabel.text = "Try Again"
            
            UIView.animate(withDuration: 0.8, animations: {ScoreLabel.frame.styleScoreLabel(container: self.view.frame)},completion: {finished in
            })
            
        }
     
        
 
    }
    
    func pickLevel(sender: trophybutton) {
        
        
       /* print("Picking level",sender.level)
        
        CurrentLevel = Levels[sender.level]
        
        GameOver = false
        
        UIView.animate(withDuration: 0.5, animations: {StartButton.frame.styleCenterButton(container: self.view.frame)})
      */
        
        
    }
    
    
    func presentNextButton()
    {
        
        if CurrentPlayer.Playing == false
        {
        
        vcGaNextButton.center = CGPoint(x: view.frame.width/2, y: 1.2*view.frame.height)
        
        UIView.animate(withDuration: 0.5, animations: {
            vcGaNextButton.frame.styleCenterButton(container: self.view.frame) })
        }
 
        
    }
    
    
    // Removes and returns a random element from the array.
    func pluckProblemFromCurrentLevel() -> Int {
        
    
        guard CurrentPlayer.myCurrentLevel.problemSet.count > 0 else {
            
            print("No more problems in this level")
            
            return 0
            
        }
        
        let rand = Int(arc4random_uniform(UInt32(CurrentPlayer.myCurrentLevel.problemSet.count)))
        
        let returnThis = CurrentPlayer.myCurrentLevel.problemSet[rand]
        
        CurrentPlayer.myCurrentLevel.problemSet.remove(at: rand)
        
        return returnThis
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
     

        view.addSubview(BackGround)
        BackGround.image = UIImage(named: "Clouds")
        BackGround.frame.styleFillContainer(container: view.frame)


        initMarbles(n: 10)
        
        
        ResponseButtons = []
        
        initResponseButtons(container: DefaultFrame)
        
        initTrophyButtons(container: DefaultFrame)
        
        

        // Add the marbles to the superview
        for marble in Marbles{
            
            marble.frame.size = CGSize(width: 50, height: 50)
            view.addSubview(marble)
            
        }
      

  
        let responseButtonFrames = getResponseButtonFrames(n: NumberOfButtons, container: view.frame)
        let trophyButtonFrames = getTrophyButtonFrames(n: NumberOfTrophies, container: view.frame)
        
        // Initialize all the response buttons.
        for (index,_) in TrophyButtons.enumerated()
        {
            
            if index < trophyButtonFrames.count
            {
    
                TrophyButtons[index].frame = trophyButtonFrames[index]
                view.addSubview(TrophyButtons[index])
                // TrophyButtons[index].setImage(EmptyTrophy, for: .normal)
                TrophyButtons[index].addTarget(self, action: #selector(pickLevel(sender:)), for: .touchUpInside)
                
            }
            
        }
        

        // Draw all the response buttons.
        for (index,_) in ResponseButtons.enumerated()
        {
            
            
            if index < responseButtonFrames.count
            {
    
                ResponseButtons[index]._n = index
                ResponseButtons[index].frame = responseButtonFrames[index]
                view.addSubview(ResponseButtons[index])
                ResponseButtons[index].addTarget(self, action: #selector(answerSubmit(sender:)), for: .touchUpInside)
                
                
            }
       
        }
         
  
        
        // Probably can remove this too.
        Levels = initLevels()
        
        initScoreLabel(container: view.frame)
        
        // Style Frames
        vcGaStartButton.frame.styleCenterButton(container: view.frame)
        vcGaNextButton.frame.styleCenterButton(container: view.frame)
        vcGaNextButton.frame.styleHideTopLeft(hide: vcGaNextButton.frame)
        vcGaBackBtn.frame.styleBackBtn(view.frame)
      
        
        // Add to superview
        view.addSubview(vcGaNextButton)
        view.addSubview(vcGaStartButton)
        view.addSubview(ScoreLabel)
        view.addSubview(vcGaBackBtn)
        view.addSubview(Modal)

        
        // Style Objects
        vcGaBackBtn.styleArrowBack()
        vcGaNextButton.styleChalkRect(text: "Next->")
        vcGaStartButton.styleChalkRect(text: "Start")
        
        
        vcGaStartButton.addTarget(self, action: #selector(startGame(sender:)), for: .touchUpInside)
        vcGaNextButton.addTarget(self, action: #selector(nextProblem(sender:)), for: .touchUpInside)
        vcGaBackBtn.addTarget(self, action: #selector(goBack(sender:)), for: .touchUpInside)
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

