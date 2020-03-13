//
//  SecondViewController.swift
//  MyNoteBook
//
//  Created by Rasmus Knoth Nielsen on 21/02/2020.
//  Copyright © 2020 Rasmus Knoth Nielsen. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var headText: UITextView!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageName: UITextField!
    
    var text = ""

    override func viewDidLoad() {
        print("Now we are in secondViewController")
        super.viewDidLoad()
        let newNote = CloudStorage.getNote(index: rowThatIsBeingEdited)
        headText.text = newNote.head
        bodyText.text = newNote.body
        // Check if note has image. If so, download it.
        if newNote.hasImage() {
            CloudStorage.downloadImage(name: newNote.imageID, iv: self.imageView)
        }
        print("Row that is being edited: \(rowThatIsBeingEdited)")
        print()
        
    
    }
    
    @IBAction func userPressedSaveButton(_ sender: UIButton) {
        print("Pressed the save button")
        print(headText.text!)
        print(rowThatIsBeingEdited)
        var fullImageName = (imageName.text ?? "")
        // If image has been set, append .jpg to the title, else leave it blank
        if fullImageName.count > 0 {
            fullImageName += ".jpg"
        }
        _ = CloudStorage.getNote(index: rowThatIsBeingEdited)
        CloudStorage.updateNote(index: rowThatIsBeingEdited, head: headText.text, body: bodyText.text, imageID: fullImageName )
        print("Image name is now: \(imageName.text!)")
        // Upload the picture from the imageView if it exists
        if fullImageName.count > 0 {
            CloudStorage.uploadImage(name: imageName.text!, image: imageView.image!)
        }
        
    }

    @IBAction func userPressedUpload(_ sender: UIButton) {
        print("User pressed upload")
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            print("user choose Photo Library")
            self.imageView.image = image
            self.imageName.text = UUID().uuidString
            print(self.imageName.text!)
        }
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
