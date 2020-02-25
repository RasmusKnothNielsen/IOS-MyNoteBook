//
//  SecondViewController.swift
//  MyNoteBook
//
//  Created by Rasmus Knoth Nielsen on 21/02/2020.
//  Copyright © 2020 Rasmus Knoth Nielsen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var detailedText: UITextView!
    var text = ""
    //var arrayIndex: Int = 0
    
    let viewController = ViewController()

    override func viewDidLoad() {
        print("Now we are in secondViewController")
        super.viewDidLoad()
        detailedText.text = textArray[rowThatIsBeingEdited]
        print("Row that is being edited: \(rowThatIsBeingEdited)")
        print()
    }
    
    @IBAction func userPressedSaveButton(_ sender: UIButton) {
        print("Pressed the save button")
        print(detailedText.text!)
        print(rowThatIsBeingEdited)
        print(textArray)
        textArray[rowThatIsBeingEdited] = detailedText.text
        viewController.saveStringToFile(str: textArray, fileName: viewController.file)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
