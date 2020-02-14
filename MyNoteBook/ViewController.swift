//
//  ViewController.swift
//  MyNoteBook
//
//  Created by Rasmus Knoth Nielsen on 14/02/2020.
//  Copyright © 2020 Rasmus Knoth Nielsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // UITableViewDelegate is used when you need to do something to a table
    
    

    @IBOutlet weak var inputLabel: UITextView!
    @IBOutlet weak var welcomeLabel: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    // Initialize empty String array
    var textArray = [String]();
    
    // Initializing variable to hold the user input in-memory
    var userInput: String = "";
    
    // Initialize variable to hold a string that has to be displayed on the screen
    var stringDisplayed = "Welcome to MyNoteBook!";
    
    // Initializing boolean to tell if we are in editing mode
    var editingRow: Bool = false;
    var rowThatIsBeingEdited: Int = -1;
    
    
    @IBAction func UserPressedButton(_ sender: Any) {
        
        // Saving the userInput here, so we can reference it later
        userInput = inputLabel.text!
        
        if editingRow
        {
            textArray[rowThatIsBeingEdited] = userInput;
        }
        else
        {
            // Add the string to the textArray
            textArray.append(userInput);
        }

        // Reload data to refresh the Table View
        tableView.reloadData();
        
        // Get the date to append to userInput
        //let todaysDate = NSDate();
        //let dateFormatter = DateFormatter();
        //dateFormatter.dateFormat = "dd-MM-yyyy";
        //let DateInFormat = dateFormatter.string(from: todaysDate as Date);
        // Concatonate Strings to save older inputs
        //userInput += String("\(DateInFormat) \n - \(inputLabel.text!) \n\n");
        
        //textLabel.text = userInput;
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textArray.append("Hello")
        textArray.append("How are you?")
        // Set these two to self, so the tableview references the app itself
        tableView.dataSource = self
        tableView.delegate = self
        
        // Display the following text at the start of the app
        welcomeLabel.text = stringDisplayed;
    }
    
    // Function that returns the number of Strings in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count;
    }
    
    // Function that displays the cells in the Table View
    // If there is two Strings in the array, the following function will be called twice.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        // Assign string from textArray to the cell
        cell?.textLabel?.text = textArray[indexPath.row]
        // return the cell, and unwrap it with the !, since it is an Optional
        return cell!
    }
    
    // Function to handle cell pressed, so we can edit it
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Transfer the text from the row to the user input field
        inputLabel.text = textArray[indexPath.row];
        // Set editing to true
        editingRow = true;
        rowThatIsBeingEdited = indexPath.row;
    }
    
    // Function to handle the deletion of a row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")

        self.textArray.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }


}

