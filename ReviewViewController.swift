import UIKit
import os.log

//where the review is created
class ReviewViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var paragraph: UITextField!
    @IBOutlet weak var delete: UIButton!
    
    
    //value is either passed in or constructed as part of adding a new review
    var review: Review?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets background color to spring green
        let greenColor=UIColor(red: 0/255.0, green: 255/255.0, blue: 127/255.0, alpha: 1.0)
        view.backgroundColor=greenColor
        
        //handle the text fields input through delegate
        nameTextField.delegate = self
        paragraph.delegate=self
        
        //sets its default to false so that when a review is being edited you can delete it
        delete.isEnabled=false
        
        //if its being edited sets the values and allows the ability to delete
        if let review = review {
            navigationItem.title=review.title
            nameTextField.text=review.title
            photoImageView.image=review.photo
            ratingControl.rating=review.rating
            paragraph.text=review.reviewwords
            delete.isEnabled=true
            
        }
        
        //allows the reviewer to rate
        ratingControl.isUserInteractionEnabled=true
        
        //enables the save button only if the text fields have values
        updateSaveButtonState()
    }
    //MARK: UITextFieldDelegate
    
    //hides the keyboard when return is clicked
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //disables save button while editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled=false
    }
    
    //when return is pressed it updates the save button and changles the navigation title
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        let text = nameTextField.text ?? ""
        if !text.isEmpty{
            navigationItem.title=nameTextField.text
        }
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    //dismiss the picker if canceled
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //when you select an image it gets the original unedited version then sets the review image to that image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary conataining an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    
    //when the user taps on the imageview the keyboard is hidden and then the phones savedphotos appears
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        present(imagePickerController, animated : true, completion : nil)
    }
    
    //MARK: Navigation
    
    //when cancel is pressed it goes back either to viewing the image or the tableview
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    //when the save button is pressed it creates a new review by getting the values of the review then setting the instance of this classes review to those values but if delete is pressed it sets the rating to 31 so that I can check it in my tablecontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        let title=nameTextField.text ?? ""
        let photo=photoImageView.image
        let rating=ratingControl.rating
        let reviewwords=paragraph.text ?? ""
        if let button=sender as? UIButton, button===delete {
            review=Review(title: title, photo: photo, rating: 31, reviewwords: reviewwords)
        }
        guard let button=sender as? UIBarButtonItem, button===saveButton else{
            os_log("The save button was not pressed cancelling", log: OSLog.default, type: .debug)
            return
        }
        review=Review(title: title, photo: photo, rating: rating, reviewwords: reviewwords)
    }
    
    //MARK: Private Methods
    
    //if the textfields are not empty then you are able to set the review
    private func updateSaveButtonState(){
        let text = nameTextField.text ?? ""
        let text2=paragraph.text ?? ""
        saveButton.isEnabled = !text.isEmpty && !text2.isEmpty
    }

}

