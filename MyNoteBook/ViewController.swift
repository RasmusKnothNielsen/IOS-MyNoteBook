//
//  ViewController.swift
//  MyNoteBook
//
//  Created by Rasmus Knoth Nielsen on 14/02/2020.
//  Copyright © 2020 Rasmus Knoth Nielsen. All rights reserved.
//

import UIKit

// Initialize empty String array
var textArray = [String]();
var rowThatIsBeingEdited: Int = -1;

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    // UITableViewDelegate is used when you need to do something to a table
    
    @IBOutlet weak var tableView: UITableView!

    @IBAction func userPressedAddHeadline(_ sender: UIButton) {
        print("Button pressed")
        textArray.append("New Headline!")
        tableView.reloadData()
        saveStringToFile(str: textArray, fileName: file)
    }
    
    
    
    // Initializing variable to hold the user input in-memory
    var userInput: String = "";
    
    // Initialize variable to hold a string that has to be displayed on the screen
    var stringDisplayed = "Welcome to MyNoteBook!";
    
    // Initializing boolean to tell if we are in editing mode
    var editingRow: Bool = false;
    
    // Variables to hold the file
    let file = "MyNoteBook.txt";
    
    // String to contain the item that we press, when shifting to new page
    var currentItem = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Read data from file
        let query = readStringFromFile(fileName: file)
        // Append every string to our notebook
        for string in query {
            textArray.append(string)
        }
        // Set these two to self, so the tableview references the app itself
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
        
        // Display the following text at the start of the app
        //welcomeLabel.text = stringDisplayed;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // Function that returns the number of Strings in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return textArray.count;
    }
    
    // Function that displays the cells in the Table View
    // If there is two Strings in the array, the following function will be called twice.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // De-queue one of the cells from the our ReusableCells, so we can reuse cells
        // in our memory. This provides us with the ability to scroll through alot of
        // cells, without filling out the system memory unnecessary.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        // Assign string from textArray to the cell
        cell?.textLabel?.text = textArray[indexPath.row]
        // return the cell, and unwrap it with the !, since it is an Optional
        return cell!
    }
    
    // This enables the transition from tableview to the view controller
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        currentItem = textArray[indexPath.row]
        rowThatIsBeingEdited = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SecondViewController {
            viewController.text = currentItem
        }
    }
    
    // EDIT
    // Function to handle cell pressed, so we can edit it
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // Transfer the text from the row to the user input field
        rowThatIsBeingEdited = indexPath.row;
        let secondViewController: SecondViewController = SecondViewController()
        print("Now we are in ViewController")
        print("Going from tableview into regular view, \(textArray[indexPath.row])")
        print("IndexPath.row is: \(rowThatIsBeingEdited)")
        print()
        secondViewController.text = textArray[rowThatIsBeingEdited];
        performSegue(withIdentifier: "showDetail", sender: nil)
        // Set editing to true
        editingRow = true;
    }
    
    // DELETE
    // Function to handle the deletion of a row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
      if editingStyle == .delete
      {
        // Remove the String at the given index
        textArray.remove(at: indexPath.row)
        // Delete the given row from the table view
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }

    // SAVING
    func saveStringToFile(str:[String] , fileName:String)
    {
        // Read the filepath
        let filePath = getDocumentDir().appendingPathComponent(fileName)
        var savingString: String = ""
        // Since we want to save several elements from our list, we are going to
        // make a long string with \n as seperator
        for string in str {
            savingString.append(string + "\n")
        }
        do {
            // Try to write the string to the provided file
            try savingString.write(to: filePath, atomically: true, encoding: .utf8)
            print("OK writing string: \(str)")
        } catch {
            print("error writing string: \(str)")
        }
    }
    
    // READING
    // Where we return a string
    func readStringFromFile(fileName:String) -> [String]
    {
        // Read the filepath
        let filePath = getDocumentDir().appendingPathComponent(fileName);
        do
        {
            // Get the content from the file and save it as string
            let string = try String(contentsOf: filePath, encoding: .utf8);
            // Since we saved the array as a string with \n seperator, we have to split it
            var returnArray = string.split(separator: "\n")
            var result: [String] = []
            // Each of the strings has to be appended to our array so we can pass it back
            for string in returnArray {
                result.append(String(string))
            }
            print("Read the following from file: \(string)")
            // Return the string
            return result;
        }
        catch
        {
            print("Error while reading file \(fileName)")
        }
        // If there was an error in reading the file, return "empty"
        return ["empty"]
    }
    
    // Function used to get the correct location on the operating system
    func getDocumentDir() -> URL
    {
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentDir[0]
    }
}

