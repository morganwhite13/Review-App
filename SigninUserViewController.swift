import UIKit
import os.log

//this is very similar to SigninView conroller with the only differences being the prepare for segue so I'm just going to comment on that
class SigninUserViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    let username="good"
    let password="app"
    @IBOutlet weak var userusername: UITextField!
    @IBOutlet weak var userpassword: UITextField!
    @IBOutlet weak var done: UIBarButtonItem!
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    var review: Review?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let greenColor=UIColor(red: 0/255.0, green: 255/255.0, blue: 127/255.0, alpha: 1.0)
        view.backgroundColor=greenColor
        userusername.delegate=self
        userpassword.delegate=self
        done.isEnabled=false
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if userusername.text==username&&userpassword.text==password{
            done.isEnabled=true
        }
    }
    
    // MARK: - Navigation
    
    //this is for when the reviewer successfully signs in to edit a review and so it sends the value of the review to the ReviewViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender:sender)
        guard let reviewDetailViewController=segue.destination as? ReviewViewController else{
            fatalError("Unexpected Destination: \(segue.destination)" )
        }
        let selectedReview=self.review
        reviewDetailViewController.review=selectedReview
    }
}

