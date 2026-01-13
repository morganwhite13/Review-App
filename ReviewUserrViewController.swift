import UIKit
import os.log

//this is a very similar view to ReviewViewController the only differences is that nothing is changeable and you have the ability to sign in to edit from here
class ReviewUserrViewController: UIViewController {
    //MARK: Properties
 
    @IBOutlet weak var usertitle: UILabel!
    @IBOutlet weak var userphoto: UIImageView!
    @IBOutlet weak var userrating: RatingControl!
    @IBOutlet weak var userparagraph: UILabel!
    var review: Review?
    
    //this does a similar setup but the difference is that it disables the userrating interaction and doesn't do everything that ReviewViewController does
    override func viewDidLoad() {
    super.viewDidLoad()
        let greenColor=UIColor(red: 0/255.0, green: 255/255.0, blue: 127/255.0, alpha: 1.0)
        view.backgroundColor=greenColor
        if let review = review{
            navigationItem.title=review.title
            usertitle.text=review.title
            userphoto.image=review.photo
            userrating.rating=review.rating
            userparagraph.text=review.reviewwords
        }
        userrating.isUserInteractionEnabled = false
    }
    
    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    //this is the main difference between ReviewViewController because when a user clicks edit this sets the signinsviewcontrollers review to this review so that it can be sent to ReviewViewController when the reviewer signs in
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    
        guard let reviewDetailViewController=segue.destination as? SigninUserViewController else{
            fatalError("Unexpected Destination: \(segue.destination)" )
        }

        let selectedReview=self.review
        reviewDetailViewController.review=selectedReview
    }
}

