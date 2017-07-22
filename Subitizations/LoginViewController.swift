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


class LoginViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var PlayerTable = UITableView()
    
    var newplayerButton = UIButton()
    
    var edit = UIButton()
    
    // var NumberShape = numbershape()
    
    func showtable()
    {
        
        view.addSubview(edit)
        //edit.frame.loginlist(view.frame)
        
        UIView.animate(withDuration: 1, animations:
            {
                // self.PlayerTable.frame.loginlist(self.view.frame)
                self.edit.editstyle(self.view.frame)
                
        })
        
    }
    
    func loadgame()
    {
        // let nextviewcontroller = controllerType.TrophyViewController
        // let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: nextviewcontroller.rawValue)
        // self.show(vc as! UIViewController, sender: vc)
      
    }
    
    
    
    func newplayer(_ sender: UIButton)
    {
        
        
        let alert = UIAlertController(title: "New Player",
                                      message: "Enter your player name",
                                      preferredStyle: .alert)
        
        
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        
                                        _ = alert.textFields!.first?.text
                                        
                                        
                                        /* Check to see if the name doesn't exist
                                        if !nameexists(name!)
                                        {
                                            
                                        }
                                            // If it does, prompt to enter another name.
                                        else
                                        {
                                            let oopsalert = UIAlertController(title: "Oops!",
                                                                              message: "That name is already taken",
                                                                              preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(action: UIAlertAction) -> Void in self.present(alert,
                                                                                                                                                                 animated: true,
                                                                                                                                                                 completion: nil)})
                                            
                                            oopsalert.addAction(okAction)
                                            
                                            self.present(oopsalert,
                                                         animated: true,
                                                         completion: nil)
                                            
                                            
                                        }
                                        */
                                        
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField) -> Void in}
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.view.setNeedsLayout()
        
        present(alert, animated: true,
                completion: nil)
        
    }
    
    
    func deleteplayer(_ sender: UIButton)
    {
        print(PlayerTable.frame.width,"TableWidth")
        
        let editing = !PlayerTable.isEditing
        
        if !editing
        {
            sender.setTitle("Edit", for: UIControlState())
        }
        else if editing
        {
            sender.setTitle("Done", for: UIControlState())
        }
        
        PlayerTable.setEditing(editing, animated: true)
        
    }
    
    // How does "Editing Style" work?
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
          
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
              /* Code for deleting
            
            context.delete(Data.players[indexPath.row] as NSManagedObject)
            Data.players.remove(at: indexPath.row)
            */
            //4
            do
            {
                try context.save()
            }
            catch let error as NSError
            {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            // remove the deleted item from the `UITableView`
            self.PlayerTable.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        // This is weird, I don't like passing data round between different parts of the model. Oh, yea I guess there's no way around this.
        // Data.CurrentPlayer = Data.players[indexPath.row]
        
        loadgame()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return tableView.frame.height/7
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.frame.size = CGSize(width: PlayerTable.frame.width, height: PlayerTable.frame.height/7)
        print(cell.frame.width,"CellWidth")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        // Create a Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! playercell
        
        // Get the data that will be used to populate the cell by access the player at the current index path.
        // _ = Data.players[indexPath.row]
        
        // Set the cell label name
        // cell.descLbl.text = p.name
        // cell.img.image = UIImage(named: "Avatar")!
        // cell.pointsLbl.text = "Points: \(p.score)"
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
       return 5
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        

        // Add the new player button
        view.addSubview(newplayerButton)
        
    
        // Setting up the player table
        PlayerTable.backgroundColor = backcolor
        PlayerTable.layer.cornerRadius = 8
        view.addSubview(PlayerTable)
        
        // Fetch the data
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        
        //3
        do
        {
            _ =
                try context.fetch(fetchRequest)
                // Data.Players = results as! [Player]
        }
        catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        
        /* If there are no players then the table does not get shown.
        if Data.players.count != 0
        {
            showtable()
            
    
            
        }
        else
        {
            newplayerButton.setTitle("Play!", for: UIControlState())
        }
 
         */
        
    }
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set the player table data source and delegate
        self.PlayerTable.dataSource = self
        self.PlayerTable.delegate = self
        self.PlayerTable.register(playercell.self, forCellReuseIdentifier: "PlayerCell")
        self.PlayerTable.separatorStyle = .none
        
        self.PlayerTable.frame = CGRect(x: 50, y: 50, width: 300, height: 300)
        
        self.PlayerTable.backgroundColor = UIColor.blue
        
        // Targets
        newplayerButton.addTarget(self, action: #selector(newplayer(_:)), for: .touchUpInside)
        
        edit.addTarget(self, action: #selector(deleteplayer(_:)), for: .touchUpInside)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

