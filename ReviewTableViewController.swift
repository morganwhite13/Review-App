import UIKit
import os.log

//this is my list of reviews controller
class ReviewTableViewController: UITableViewController {
    
    //MARK: Properties
    
    //list of the reviews it has
    var reviews=[Review]()

    //this sets the background color and loads the precreated reviews
    override func viewDidLoad() {
        super.viewDidLoad()
        let greenColor=UIColor(red: 0/255.0, green: 255/255.0, blue: 127/255.0, alpha: 1.0)
        view.backgroundColor=greenColor
        loadSampleReviews()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //the amount of rows is how ever many reviews there are
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    //this is what sets each cell to have its title, image, and rating and sets the color of it
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ReviewTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ReviewTableViewCell else{
            fatalError("The dequeued cell is not an instance of ReviewTableViewCell")
        }
        let review = reviews[indexPath.row]
        cell.nameLabel.text=review.title
        cell.photoImageView.image=review.photo
        cell.ratingControl.rating=review.rating
        let greenColor=UIColor(red: 0/255.0, green: 255/255.0, blue: 127/255.0, alpha: 1.0)
        cell.backgroundColor=greenColor
        return cell
    }
    
    // MARK: - Navigation

    //this is called when moving between scenes if a new review is being made nothing really happens but if ones being viewed SigninUserViewController needs the review information which this does and sets the information up for it
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new review", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let reviewDetailViewController = segue.destination as? ReviewUserrViewController else{
                fatalError("Unexpected Destination: \(segue.destination)" )
            }
            guard let selectedReviewCell = sender as? ReviewTableViewCell else{
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedReviewCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedReview=reviews[indexPath.row]
            reviewDetailViewController.review=selectedReview
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    

    //MARK: Actions
    
    //this is called upon whenever a scene sends the user here and this basically checks if a review was being edited and if so checks if the rating is 31 which means that the review needs to be deleted and so it does that if not it updates that cell but if a review wasn't being edited then it creates a brand new cell with the corresponding info
    @IBAction func unwindToReviewList(sender: UIStoryboardSegue){
        if let sourceViewController=sender.source as? ReviewViewController, let review = sourceViewController.review {
            if let selectedIndexPath=tableView.indexPathForSelectedRow{
                if review.rating==31{
                    reviews.remove(at: selectedIndexPath.row)
                    tableView.deleteRows(at: [selectedIndexPath], with: .fade)
                }
                else{
                    reviews[selectedIndexPath.row] = review
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
            }
            else{
                let newIndexPath=IndexPath(row: reviews.count, section: 0)
                reviews.append(review)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    //MARK: Private Methods
    
    //this is just the preprogrammed reviews that I have made and this just adds to the list of reviews
    private func loadSampleReviews(){
        let photo1=UIImage(named: "review1")
        let photo2=UIImage(named: "review2")
        let photo3=UIImage(named: "review3")
        let photo4=UIImage(named: "review4")
        let photo5=UIImage(named: "review5")
        let photo6=UIImage(named: "review6")
        let photo7=UIImage(named: "review7")
        guard let review1=Review(title: "DC's best movie yet: Shazam!", photo: photo1, rating:5, reviewwords: "Shazam is by far the best movie in the DCEU with a ton of light hearted comedy paired with the powers of Shazam! it completely deserves five stars and you should definitely check it out if you have the chance.")else{
            fatalError("Unable to instantiate review1")
        }
        guard let review2=Review(title: "The Biggest Error in Avengers Endgame!", photo: photo2, rating:4, reviewwords: "Warning Spoilers:                                                                                                                                                                                                                                              Avengers Endgame is very good without a doubt but if you consider that it took 21 films and $4.5 billion in budget to get to this movie for them to end it with them literally breaking the time travel rules that they clearly set is just so disappointing.")else{
            fatalError("Unable to instantiate review2")
        }
        guard let review3=Review(title: "John Wick 3 and the Endless Action!", photo: photo3, rating:4, reviewwords: "If you enjoy insane action sequences you will love this movie!")else{
            fatalError("Unable to instantiate review3")
        }
        guard let review4=Review(title: "Black Ops 4 Where are the Changes?", photo: photo4, rating:2, reviewwords: "Basically Black Ops 3 but with minor adjustments and upgrades.")else{
            fatalError("Unable to instantiate review")
        }
        guard let review5=Review(title: "Morgan's Reviews the Best App Ever", photo: photo5, rating:5, reviewwords: "If your looking to find good entertainment without spoilers you have got to get that app!")else{
            fatalError("Unable to instantiate review")
        }
        guard let review6=Review(title: "Computer Science the best subject", photo: photo6, rating:5, reviewwords: "If your looking for a great, important course to take you have to take Computer Science!")else{
            fatalError("Unable to instantiate review")
        }
        guard let review7=Review(title: "SuperStore the soon to be superstar show", photo: photo7, rating:4, reviewwords: "If your looking for the show that is easily comparible to the greatness of The Offfice this is your show!")else{
            fatalError("Unable to instantiate review")
        }
        reviews+=[review1, review2, review3, review4, review5, review6, review7]
    }
}
