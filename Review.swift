import UIKit

//this is the class document of Review
class Review{
    //MARK: Properties
    
    var title: String
    var photo: UIImage?
    var rating: Int
    var reviewwords: String
    
    //MARK: Initialization
    
    //where the values of the review are passed in
    init?(title:String, photo: UIImage?, rating: Int, reviewwords: String){
        //The name & paragraph must not be empty
        guard !title.isEmpty && !reviewwords.isEmpty else{
            return nil
        }
        //The rating must be between 0 and 5 iclusively or 31 as a way to delete the rating in the tableview
        guard(((rating>=0)&&(rating<=5))||rating==31)else{
            return nil
        }
        
        self.title=title
        self.photo=photo
        self.rating=rating
        self.reviewwords=reviewwords
    }
}
