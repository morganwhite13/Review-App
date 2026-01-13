import UIKit
import os.log

//this is where the reviewer most likely me(morgan) signs in to create and edit reviews
class SigninViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    //this is the username and password necessary to edit and create reviews
    let username="good"
    let password="app"
    @IBOutlet weak var userusername: UITextField!
    @IBOutlet weak var userpassword: UITextField!
    //if cancel is pressed you go to previous scene
    @IBAction func cancel2(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var done: UIBarButtonItem!
    
    //sets background color, sets the delegates and disables the done button so that you have to sign in
    override func viewDidLoad() {
        super.viewDidLoad()
        let greenColor=UIColor(red: 0/255.0, green: 255/255.0, blue: 127/255.0, alpha: 1.0)
        view.backgroundColor=greenColor
        userusername.delegate=self
        userpassword.delegate=self
        done.isEnabled=false
    }
    
    //MARK: UITextFieldDelegate
    
    //hides keyboard when necessary
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //checks if the username and password have been enetered correctly
    func textFieldDidEndEditing(_ textField: UITextField) {
        if userusername.text==username&&userpassword.text==password{
            done.isEnabled=true
        }
    }
}
