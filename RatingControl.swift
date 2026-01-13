import UIKit

//controls the rating system also has voiceover functionality
@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    
    //is an array of buttons so you can press multiple buttons
    private var ratingButtons=[UIButton]()
    //the default rating is 0 but can be set to different rating
    var rating=0{
        didSet{
            updateButtonSelectionStates()
        }
    }
    //declares the size of the buttons in the stack and sets them up
    @IBInspectable var starSize: CGSize=CGSize(width:44.0, height: 44.0){
        didSet {
            setupButtons()
        }
    }
    //sets up the amount of stars
    @IBInspectable var starCount: Int=5{
        didSet{
            setupButtons()
        }
    }
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupButtons()
    }
    required init(coder: NSCoder){
        super.init(coder: coder)
        setupButtons()
    }
    //MARK: Button Action
    
    //when one of the stars is pressed this figures out which star was pressed and if it was what was there the rating becomes 0 otherwise whatever button was pressed
    @objc func ratingButtonTapped(button:UIButton){
        guard let index = ratingButtons.firstIndex(of: button) else{
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        let selectedRating=index+1
        if selectedRating==rating{
            rating = 0
        } else{
            rating=selectedRating
        }
    }
    
    //MARK: Private Methods
    
    //this function clears all buttons then gets the images of the states of the buttons and sets the different states of the buttons to the corresponding image, sets the constraints, and sets the button action then adds the button to the array
    private func setupButtons(){
        //clear any existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        //Load Button Images
        let bundle=Bundle(for:type(of:self))
        let filledStar=UIImage(named: "filledStar", in:bundle, compatibleWith: self.traitCollection)
        let emptyStar=UIImage(named:"emptyStar", in:bundle, compatibleWith: self.traitCollection)
        let highlightedStar=UIImage(named:"highlightedStar", in:bundle, compatibleWith: self.traitCollection)
        for index in 0..<starCount{
            let button=UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive=true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive=true
            button.accessibilityLabel="Set \(index + 1) star rating"
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
    }
    
    //this function is for updating the states of the buttons by getting the selected button and setting the image based on the state as well as has voiceover functionality
    private func updateButtonSelectionStates(){
        for(index, button)in ratingButtons.enumerated(){
            button.isSelected=index<rating
            let hintString: String?
            if rating==index+1{
                hintString="Tap to reset the rating to zero"
            }else{
                hintString=nil
            }
            let valueString:String
            switch(rating){
            case 0:
                valueString="No rating set"
            case 1:
                valueString="1 star set"
            default:
                valueString="\(rating) stars set"
            }
            button.accessibilityHint=hintString
            button.accessibilityValue=valueString
        }
    }
}
