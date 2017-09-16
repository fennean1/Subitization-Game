//
//  ViewController.swift
//  Subitizations
//
//  Created by Andrew Fenner on 7/12/17.
//  Copyright © 2017 Andrew Fenner. All rights reserved.
//

import UIKit

// --- UI Elements ---

var vcGaStartButton = UIButton()

var vcGaNextButton = UIButton()

var vcGaBackBtn = UIButton()

// For whether or not a game has been started with vc Exits. Should be removed eventually.
var vcGaDidInit = false

var ScoreLabel: UILabel!

var vcGaCounterImage = PinkBall

var vcGaMainMarble = BlueBall

var vcGaAccentMarble = OrangeBall

// Legacy - Needs to adopt namespace vcGa(VariableName)
var dT: CGFloat = 0

// The two marbles that will be used in a given turn. User can choose these at the beginning of the game and may change them between turns.
var MainMarble = BlueBall

var AccentMarble = OrangeBall

var GameOver = false

// Theoretically, there should be multiple levels. A level just stores the numbers that will be displayed in that level. That's why right now the "Current Level" is just 3 of each number. These numbers are presented randomely.
var CurrentLevel = [1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7,8,8,8,9,9,9,10,10,10]

// A modal that lets the player know when the game is over and displays performance data.
var Modal = modalview()

// Created with the notion that there would be multiple players. I'm sidelining that feature for the first release.
var CurrentPlayer: player!

var Attempts = 0

var currentTime: Double = 0
var timeOfTurnStart: Double = 0

var TimeElapsed: Double = 0

// The number being presented.
var Argument = 0

// --- Styles ---

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





func initScoreLabel(container: CGRect)
{
    
    ScoreLabel = UILabel()
    
    ScoreLabel.frame.styleScoreLabel(container: container)
    ScoreLabel.font = UIFont(name: "ChalkBoard SE", size: 70)
    ScoreLabel.textAlignment = .center
    
}


// USE DID SET TO MAKE SURE THAT DEPENDENCIES GET PROPAGATED


class GameViewController: UIViewController {
    
    
    
    @IBOutlet weak var timeTracker: UILabel!
    
    
    var localTimer = Timer()

    
    // Array of marbles that get displayed during the game
    var Marbles: [marble] = []
    
    var ResponseButtons: [responsebutton] = []
    
  

    var vcGaTrophyButtons: [trophybutton] = []

    
    // When accented marblles are updated, update
    var vcGaAccentedMarbles: Int = 0 {
        
        didSet(newValue) {
            
            for (i,b) in ResponseButtons.enumerated()
            {
            
                ResponseButtons[newValue].drawNumber(n: newValue, image: vcGaAccentMarble)
                
            }
        }
        
        
    }

    // Initialization
    func initTrophyButtons(container: CGRect) {
        
        
        for index in 0...9
        {
            
            let newButton = trophybutton()
            
            newButton.level = index
            
            vcGaTrophyButtons.append(newButton)
            
        }
        
        
    }
    
    func initResponseButtons(container: CGRect) {
        
        for _ in 1...10
        {
            
            let newButton = responsebutton(frame: container)
            
            ResponseButtons.append(newButton)
            
        }
        
    }

    
    func startGame(sender: UIButton)
    {
        for trophy in vcGaTrophyButtons
        {
            trophy.setImage(nil, for: .normal)
        }
        
        // Drawing the buttons (because they get rendered each turn.
        for (index,button) in ResponseButtons.enumerated()
        {
            button.drawNumber(n: index + 1, image: vcGaMainMarble)
        }
        
        // Create new player
        CurrentPlayer = player()
        CurrentPlayer.playing = true
        CurrentPlayer.initPerformanceDataContext()
        print("The new player's performance data context has been set to:",CurrentPlayer.myPerformanceData)
        Attempts = 0
     
        
        // Returns a value but
        _ = presentNewProblem()
    
        // Hide the start button
        hide(view: sender)
        
    }
    
    
    
    func goBack(sender: UIButton) {
        
        print("Resetting the game variables")

        
        GameOver = false
        
        Attempts = 0
        
        currentTime = 0
        timeOfTurnStart = 0
    
        
        Marbles = []
        
        TimeElapsed = 0
        
        centers = []
        
        ResponseButtons = []
        
        Argument = 0
        
        // Numbers get plucked away from the level during the game, that's why they must be replaced upon exit.
        CurrentLevel = [1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7,8,8,8,9,9,9,10,10,10]
        
        CurrentPlayer.playing = false
        
        localTimer.invalidate()

        
        print("Going back to WelcomeViewController")
        
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "WelcomeViewController")
        
        self.show(vc as! UIViewController, sender: vc)
        
    }
    
    func presentNewProblem() -> Bool
    {
        
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
        CurrentPlayer.playing = true

        
    
        drawConfiguration(value: Argument, at: view.center, marbles: Marbles, ballimage: MainMarble, marblesize: 50)
    

        return true
        
    }
    
    func updateTimer()
    {
        currentTime += 0.01
        timeTracker.text = "\(currentTime)"
    }
    
    
    func nextProblem(sender: UIButton)
    {
        
        // Check to see if presentNewProblem() returns true. This actually calls presentNewProblem.
        guard presentNewProblem() == true else {
            
            // ENDING GAME
            print("presentNewProblem has returned false and the game is over.")
            CurrentPlayer.playing = false
           
            
            // ACTION: Need to present the user with options on how to proceed once the game has concluded. Could use Modal defined in "Library"
            
            
            // Reset The level
            CurrentPlayer.initPerformanceDataContext()
            
            let earnedTrophy = trophy(percentage: Score/Normalizer)!
            
            Score = 0
            dT = 0
            
            
            // Need to re - write modal so it can handle next user action. 
            Modal.drop(earnedTrophy, messege: "Score: \(Score)")
            
            vcGaStartButton.frame.styleCenterButton(container: self.view.frame)
            
            return
            
        }
        
        timeOfTurnStart = currentTime
        
        CurrentPlayer.playing = true
        
        hide(view: vcGaNextButton)
        
        ScoreLabel.text = "Total: \(Int(Score))"
        
    }
    
    
    func answerSubmit(sender: responsebutton) {
        
        
        
        // If the player isn't playing then nothing should happen when these buttons are pressed. We used the Bool "Playing" state so we don't have to disable each button everytime we don't want them to respond.
        guard CurrentPlayer.playing == true else {
            
            print("Shouldn't be able to press me!")
            
            return
            
        }
        
    
        
        ScoreLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        print("The score label frame has been set to RectZero prior to animation")
  
        
        let originalCenters = Marbles.map({$0.center})
        
        
       // Pushes an array of points outward from their collective center.
       let bouncedCenters = bouncePoints(points: originalCenters, center: self.view.center)
        
        // sender._n? why did I name that _n?
        if sender._n == Argument {
            
            dT = CGFloat(currentTime - timeOfTurnStart)
    
            CurrentPlayer.playing = false
            print("The current player is no longer in the Playing state and must press Next to go to the next turn")

            print("It took you:",dT,"seconds")
            let newScore = calculateScore(dT: dT,number: Argument,attempts: Attempts)
            print("The new score has been calculated:",newScore,"Points")
            
            Attempts = 0
            print("The correct answer has been received and the number of attempts have been set back to:",Attempts)
            

            Score = Score + CGFloat(newScore)
            
            // Present feedback
            ScoreLabel.text = "\(Int(newScore)) Points!"
            
            CurrentPlayer.updatePerfomanceDataFor(n: Argument, with: CGFloat(newScore))
            
            // Need to update score
            vcGaTrophyButtons[Argument-1].updateTrophy(percentage: CurrentPlayer.myPerformanceData[Argument-1].1/Normalizer)
            
            UIView.animate(withDuration: 0.4, animations: {ScoreLabel.frame.styleScoreLabel(container: self.view.frame)},completion: {finished in })
            
            
            // Creates a timer that does not repeat Present "Next" Button
            let _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(presentNextButton)), userInfo: nil, repeats: false)
            
            
            // Show the true shape
            drawNumberShape(value: Argument, at: view.center,marbles: Marbles, ballimage: vcGaCounterImage, marblesize: 50)
            
            
            
        }
        else {
            

            Attempts += 1
            print("A new attempt has been recorded and the total count is now:",Attempts)
            
            
            UIView.animate(withDuration: 0.3, animations: {
                
                for (j,m) in self.Marbles.enumerated()
                {
                    
                    m.center = bouncedCenters[j]
                    
                    
                    
                }
                
            },
            completion: {finished in

             
            UIView.animate(withDuration: 0.3, animations: {
                    
                    print("Animating to original centers",originalCenters)
                    
                    
                    for (i,m) in self.Marbles.enumerated()
                    {
                        m.center = originalCenters[i]
                    }
                    
                })
 

 
            })

 
            ScoreLabel.text = "Try Again"
            
            UIView.animate(withDuration: 0.8, animations: {ScoreLabel.frame.styleScoreLabel(container: self.view.frame)},completion: {finished in
            })
            
        }
     
        print("The players performance data is",CurrentPlayer.myPerformanceData)
 
    }
    
    
    func presentNextButton()
    {
        
        if CurrentPlayer.playing == false
        {
        
        vcGaNextButton.center = CGPoint(x: view.frame.width/2, y: 1.2*view.frame.height)
        
        UIView.animate(withDuration: 0.5, animations: {
            vcGaNextButton.frame.styleCenterButton(container: self.view.frame) })
        }
 
        
    }
    
    
    // Removes and returns a random element from the array.
    func pluckProblemFromCurrentLevel() -> Int {
        
    
        guard CurrentLevel.count > 0 else {
            
            print("No more problems in this level")
            
            return 0
            
        }
        
        let rand = Int(arc4random_uniform(UInt32(CurrentLevel.count)))
        
        let returnThis = CurrentLevel[rand]
        
        CurrentLevel.remove(at: rand)
        
        return returnThis
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // Initializes the marble array (currently always n = 10...but you never know.)
    func initMarbles(n: Int) {
        
        for _ in 1...n
        {
            
            let newMarble = marble(frame: DefaultFrame)
            
            newMarble.frame.size = CGSize(width: BallSize, height: BallSize)
            
            Marbles.append(newMarble)
            
        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    
        localTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
        
        
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
        
        // Initialize all the trophy buttons
        for (index,_) in vcGaTrophyButtons.enumerated()
        {
            
            if index < trophyButtonFrames.count
            {
    
                vcGaTrophyButtons[index].frame = trophyButtonFrames[index]
                view.addSubview(vcGaTrophyButtons[index])
                
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
        
        
        print("Time of Turn Start",timeOfTurnStart)
        
         view.bringSubview(toFront: timeTracker)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

