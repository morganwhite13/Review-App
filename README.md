# Morgan's Reviews - iOS Entertainment Review App

A native iOS review application built in Swift that allows reviewers to create, edit, and publish spoiler-free reviews of movies, TV shows, games, and other entertainment. Users can browse reviews with star ratings, images, and detailed commentary, while the reviewer maintains editorial control through a secure sign-in system.

**[Live Demo Video](https://www.youtube.com/watch?v=sYmV_4kQiN8)**

---

## 🎯 Overview

Morgan's Reviews is a demonstration of end-to-end iOS application development using Apple's UIKit framework. The app implements a dual-interface design pattern that serves two distinct user groups:

- **Reviewers** (authenticated): Full CRUD operations for review management
- **General Users**: Read-only browsing experience

The app ships with 7 pre-loaded sample reviews across multiple entertainment categories and provides a clean, intuitive interface with robust state management.

---

## ✨ Key Features

### 📝 Review Management
- **Create** new reviews with title, body text, and images
- **Edit** existing reviews while maintaining data integrity
- **Delete** reviews through secure authentication
- Real-time save button state management
- Text field validation (title and review text required)

### ⭐ Custom Rating System
- Interactive 5-star rating component built with UIStackView
- Toggle functionality (tap same rating to reset to 0)
- VoiceOver accessibility support for screen readers
- Configurable star count and size via `@IBInspectable`
- Read-only mode for general users

### 🔐 Dual Authentication System
- **SigninViewController**: Authentication for new reviews
- **SigninUserViewController**: Authentication for editing existing reviews
- Simple credential validation (username: "good", password: "app")
- Maintains review context through navigation chains

### 📸 Rich Media Support
- UIImagePickerController integration
- Photo library access with permission handling
- Image persistence through Review model
- Original, unedited image extraction

### 🎨 User Interface
- Spring green color scheme (RGB: 0, 255, 127)
- Clear visual hierarchy and ample spacing
- Seamless navigation between viewing and editing modes
- Responsive layout for iPhone and iPad

### ♿ Accessibility
- VoiceOver screen reader support
- Descriptive accessibility labels on interactive elements
- Current rating announcements
- Reset hints for enhanced navigation

---

## 🏗️ Architecture

The app follows the **Model-View-Controller (MVC)** pattern with a clean separation of concerns.

### Project Structure

```
morgansreview/
├── Models/
│   └── Review.swift              # Core data model with validation
├── Views/
│   ├── RatingControl.swift       # Custom UIStackView-based star rating
│   └── ReviewTableViewCell.swift # Custom table cell for review list
├── Controllers/
│   ├── ReviewTableViewController.swift       # Main list view
│   ├── ReviewUserrViewController.swift       # Read-only review detail
│   ├── ReviewViewController.swift            # Edit/create interface
│   ├── SigninViewController.swift            # Auth for new reviews
│   └── SigninUserViewController.swift        # Auth for editing reviews
└── AppDelegate.swift             # Application lifecycle
```

### Data Model

```swift
class Review {
    var title: String
    var photo: UIImage?
    var rating: Int           // 0-5 or 31 (delete sentinel)
    var reviewwords: String
    
    init?(title: String, photo: UIImage?, rating: Int, reviewwords: String)
}
```

**Validation:**
- Title and review text cannot be empty
- Rating must be 0-5 or 31 (sentinel for deletion)
- Failable initializer returns `nil` for invalid data

### Navigation Flow

```
ReviewTableViewController (Main List)
    ├── [Tap Review] → ReviewUserrViewController (Read-Only)
    │                   └── [Edit Button] → SigninUserViewController
    │                                       └── [Auth Success] → ReviewViewController
    └── [+ Button] → SigninViewController
                     └── [Auth Success] → ReviewViewController
```

---

## 🚀 Getting Started

### Requirements

- **macOS** 10.13 or later
- **Xcode** 10.2 or later
- **iOS** 12.0 or later (target deployment)
- **Swift** 5.0 or later

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/morgans-reviews.git
   cd morgans-reviews
   ```

2. **Open in Xcode:**
   ```bash
   open morgansreview.xcodeproj
   ```

3. **Build and run:**
   - Select an iPhone simulator or connected device
   - Press `Cmd + R` to build and run

### Demo Credentials

To access the review creation and editing interface:

- **Username:** `good`
- **Password:** `app`

---

## 📱 Usage

### Browsing Reviews

1. Launch the app to view the main review list
2. Tap any review to read the full details
3. View title, image, rating, and detailed commentary
4. Use the back button to return to the list

### Creating Reviews

1. Tap the **+** button in the navigation bar
2. Enter your credentials (username: "good", password: "app")
3. Tap **Done** to proceed
4. Fill in the review details:
   - **Title:** Review headline
   - **Image:** Tap the image area to select from photo library
   - **Rating:** Tap stars (1-5, tap again to reset)
   - **Text:** Detailed review commentary
5. Tap **Save** to publish (button only enabled when title and text are filled)

### Editing Reviews

1. Tap any review in the list
2. Tap the **Edit** button
3. Enter your credentials to authenticate
4. Modify any field:
   - Update title, image, rating, or review text
   - The **Delete** button becomes available in edit mode
5. Tap **Save** to update or **Delete** to remove

---

## 🛠️ Technical Details

### Design Patterns

- **Model-View-Controller (MVC):** Clean separation between data, presentation, and logic
- **Delegation:** UITextFieldDelegate, UIImagePickerControllerDelegate, UITableViewDelegate/DataSource
- **Target-Action:** Button interactions and bar button items
- **Optional Chaining:** Safe unwrapping throughout the codebase
- **Failable Initializers:** Data validation at creation time
- **Property Observers:** State synchronization with `didSet`

### Key Implementation Highlights

**Custom Star Rating:**
- UIStackView-based component with dynamic button management
- Custom image asset loading from bundle
- Programmatic constraint setup with Auto Layout
- State synchronization via property observers

**Save Button Management:**
- Text field delegation monitors editing state
- Button disabled during active editing
- Re-enabled only when both title and review text are filled

**Delete Operation:**
- Sentinel value (rating = 31) signals deletion intent
- ReviewTableViewController detects sentinel and removes row
- Preserves clean UI without exposed delete actions

**Data Persistence Through Navigation:**
- Review objects passed through segue chains
- Type-safe unwrapping with guard statements
- Optional `var review: Review?` maintained in each controller

---

## 📊 Pre-Loaded Content

The app ships with 7 sample reviews:

| Title | Rating | Category |
|-------|--------|----------|
| DC's best movie yet: Shazam! | ⭐⭐⭐⭐⭐ | Movie |
| The Biggest Error in Avengers Endgame! | ⭐⭐⭐⭐ | Movie |
| John Wick 3 and the Endless Action! | ⭐⭐⭐⭐ | Movie |
| Black Ops 4 Where are the Changes? | ⭐⭐ | Game |
| Morgan's Reviews the Best App Ever | ⭐⭐⭐⭐⭐ | App |
| Computer Science the best subject | ⭐⭐⭐⭐⭐ | Education |
| SuperStore the soon to be superstar show | ⭐⭐⭐⭐ | TV Show |

---

## 🎓 Learning Outcomes

This project demonstrates proficiency in:

### iOS Development Fundamentals
- UIKit framework and view hierarchy
- Storyboard-based UI design with programmatic constraints
- Navigation controller stack management
- Delegate pattern and protocol conformance

### Swift Language Features
- Optional handling and guard statements
- Property observers (didSet, willSet)
- Failable initializers for validation
- Type safety and casting
- String interpolation and optionals

### User Experience Design
- Authentication flow design
- State management across multiple view controllers
- Accessibility considerations (VoiceOver)
- Visual feedback for user actions

### Table View Mastery
- Custom cell creation and registration
- Dynamic row insertion/deletion with animation
- Cell reuse and performance optimization
- Section and row management

### Advanced Topics
- Custom UIStackView subclassing
- Image handling and persistence
- Unwind segues and complex navigation
- Text field delegation and validation

---

## 🔄 Project Evolution

### Original Vision (April 2019)
- Multi-category review system for movies, TV, games, products, books
- Alternative to trailers that give away plots
- Personality-based recommendation algorithm
- Cross-platform deployment

### What Was Achieved ✅
- Multi-category review system
- Spoiler-free review format
- Clean, article-style presentation
- Star rating system for quick assessment
- Rich media support with images
- Editorial control through authentication

### Intentional Simplifications ⚠️
- Single-reviewer focused (vs. public user submissions)
- No personality-based recommendations
- iOS only (vs. cross-platform)

**Reflection:** The scope reduction was strategic for a school project timeline, allowing focus on core iOS development skills while delivering a polished, functional application.

---

## 🚀 Future Enhancements

If extended today, the following improvements would be valuable:

1. **Firebase Backend** - Cloud database for true data persistence
2. **SwiftUI Rewrite** - Modernize using declarative UI framework
3. **User Accounts** - Multiple reviewers with profiles
4. **Search & Filtering** - Find reviews by category, rating, or keyword
5. **Rich Text Editor** - Markdown support for formatted reviews
6. **Share Functionality** - Export reviews to social media platforms
7. **Dark Mode Support** - Respect system appearance preferences
8. **iPad Optimization** - Split-view layout for larger screens
9. **Localization** - Multi-language support
10. **Analytics** - Track most-viewed reviews and user engagement

---

## 💻 Technologies Used

### Languages & Frameworks
- **Swift 5.0** - Programming language
- **UIKit** - User interface framework
- **Foundation** - Core framework utilities

### Development Tools
- **Xcode 10.2+** - Integrated development environment
- **Interface Builder** - Visual UI designer
- **iOS Simulator** - Testing environment

### Key APIs
- `UITableView` & `UITableViewController`
- `UIImagePickerController`
- `UINavigationController`
- `UITextField` & `UITextFieldDelegate`
- `Auto Layout` (NSLayoutConstraint)
- `Bundle` & `Asset Catalog`

---

## 📋 File Reference

| File | Lines | Purpose |
|------|-------|---------|
| `Review.swift` | 30 | Core data model with validation |
| `RatingControl.swift` | 130 | Custom star rating component |
| `ReviewTableViewCell.swift` | 25 | Table cell for review list |
| `ReviewTableViewController.swift` | 140 | Main list view controller |
| `ReviewUserrViewController.swift` | 50 | Read-only review detail view |
| `ReviewViewController.swift` | 140 | Edit/create review interface |
| `SigninViewController.swift` | 45 | Authentication for new reviews |
| `SigninUserViewController.swift` | 50 | Authentication for editing |
| `AppDelegate.swift` | 40 | Application lifecycle |
| **Total** | **600+** | Complete application |

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Morgan White**

- Created: April-May 2019
- Platform: iOS 12.0+
- Status: Complete and Deployed

---

## 📞 Contact & Support

- [**Portfolio**](https://morganwhite13.github.io/)
- [**Email**](morgan13white@icloud.com)
- [**LinkedIn**](https://www.linkedin.com/in/morgan-white-95b245237/)

---

## 🙏 Acknowledgments

- Apple's [UIKit Documentation](https://developer.apple.com/documentation/uikit/)
- Swift.org community resources
- School project mentorship and feedback

---

**[⬆ back to top](#morgans-reviews---ios-entertainment-review-app)**
