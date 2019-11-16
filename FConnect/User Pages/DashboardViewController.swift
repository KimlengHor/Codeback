//
//  DashboardViewController.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //IBOutlets
    @IBOutlet weak var foryouCollectionView: UICollectionView!
    @IBOutlet weak var otherResourceCollectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var profileContainerView: UIView!
    @IBOutlet weak var profileTapImageView: UIImageView!
    @IBOutlet weak var houseTapImageView: UIImageView!

    //variables
    var recruiters = [Recruiter]()
    var questions = [Question]()
    var answerOptionArray = [Bool]()
    var uid = ""
    var currentUser: User!
    var userPreferences = [Userpreference]()
    var type = "food"
        
    //database
    fileprivate func fetchSponser(completion: @escaping ([Recruiter]) -> ()) {
        
        var recruiters = [Recruiter]()
        
        Firestore.firestore().collection("recruiters").getDocuments { (snapshots, error) in
            if let error = error {
                print("Failed fetching the sponser information ", error)
                return
            }
            
            for document in snapshots!.documents {
                let recruiter = Recruiter(dictionary: document.data())
                recruiters.append(recruiter)
            }
            
            completion(recruiters)
        }
    }
    
    fileprivate func fetchQuestions(completion: @escaping ([Question]) -> ()) {
        var questions = [Question]()
        
        Firestore.firestore().collection("questions").getDocuments { (snapshots, error) in
            if let error = error {
                print("Failed fetching the sponser information ", error)
                return
            }
            
            for document in snapshots!.documents {
                let question = Question(dictionary: document.data())
                questions.append(question)
            }
            
            completion(questions)
        }
    }
    
    fileprivate func getUserPreference(category: String) {
        Firestore.firestore().collection(category).getDocuments { (snapshots, error) in
            if let error = error {
                print(error)
                return
            } else {
                for document in snapshots!.documents {
                    let userPref = Userpreference(dictionary: document.data())
                    self.userPreferences.append(userPref)
                    self.foryouCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch from the database
        
        fetchQuestions { (questions) in
            print(questions[0].answer)
            print(questions[0].keywords)
            self.questions = questions
            self.foryouCollectionView.reloadData()
        }
        
        fetchSponser { (recruiters) in
            self.recruiters = recruiters
            self.otherResourceCollectionView.reloadData()
        }

        uid = Auth.auth().currentUser?.uid ?? ""
        
        //getQuestionAnswers()
        getUserPreference(category: "food3")
        
        setupView()
        
        scheduleNotification()
    }
    
    func scheduleNotification() {
        //notification part
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Announcement"
        content.body = "Hey! Second Harvest Food Bank is giving out free food supplies on tomorrow, Monday (11/4) at 201, 4th St, San Jose"
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "local-notification-fconnect"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: {(error) in
            if let error = error {
                print(error)
            }
        })
    }
    
//    func getQuestionAnswers() {
//        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, error) in
//            if let error = error {
//                print(error)
//                return
//            } else {
//                if let userData = snapshot?.data() {
//                    self.currentUser = User(dictionary: userData)
//
//                    if !(self.currentUser.questionAnswer[0] as! Bool) {
//                        self.cookingButton.isHidden = true
//                    }
//
//                    if !(self.currentUser.questionAnswer[1] as! Bool) {
//                        self.housingButton.isHidden = true
//                    }
//
//                    if !(self.currentUser.questionAnswer[2] as! Bool) {
//                        self.transportationButton.isHidden = true
//                    }
//
//                    if !(self.currentUser.questionAnswer[3] as! Bool) {
//                        self.counselingButton.isHidden = true
//                    }
//
//                    if !(self.currentUser.questionAnswer[4] as! Bool) {
//                        self.educationButton.isHidden = true
//                    }
//                }
//            }
//        }
//    }
    
    fileprivate func setupView() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        foryouCollectionView.delegate = self
        foryouCollectionView.dataSource = self
        
        otherResourceCollectionView.delegate = self
        otherResourceCollectionView.dataSource = self
        
        addButton.createRoundCorner(cornerRadius: self.addButton.frame.height / 2)
        
        profileContainerView.isHidden = true
        
        profileTapImageView.isUserInteractionEnabled = true
        let profileTap = UITapGestureRecognizer(target: self, action: #selector(showProfileTap))
        profileTapImageView.addGestureRecognizer(profileTap)
        
        houseTapImageView.isUserInteractionEnabled = true
        let houseTap = UITapGestureRecognizer(target: self, action: #selector(showHouseTap))
        houseTapImageView.addGestureRecognizer(houseTap)
        
        //resetChoiceTap()
        //cookingButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let houseTintableImage = #imageLiteral(resourceName: "Item 1").withRenderingMode(.alwaysTemplate)
        houseTapImageView.image = houseTintableImage
        houseTapImageView.tintColor = #colorLiteral(red: 0.1412371695, green: 0.7504014373, blue: 0.4530068636, alpha: 1)
    }
    
//    fileprivate func resetChoiceTap() {
//        let cookingTintableImage = #imageLiteral(resourceName: "cooking").withRenderingMode(.alwaysTemplate)
//        cookingButton.setImage(cookingTintableImage, for: .normal)
//        cookingButton.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        let housingTintableImage = #imageLiteral(resourceName: "houses").withRenderingMode(.alwaysTemplate)
//        housingButton.setImage(housingTintableImage, for: .normal)
//        housingButton.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        let transportationTintableImage = #imageLiteral(resourceName: "parking").withRenderingMode(.alwaysTemplate)
//        transportationButton.setImage(transportationTintableImage, for: .normal)
//        transportationButton.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        let counselingTintableImage = #imageLiteral(resourceName: "assigment").withRenderingMode(.alwaysTemplate)
//        counselingButton.setImage(counselingTintableImage, for: .normal)
//        counselingButton.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        let educationTintableImage = #imageLiteral(resourceName: "student").withRenderingMode(.alwaysTemplate)
//        educationButton.setImage(educationTintableImage, for: .normal)
//        educationButton.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//    }
    
    @objc fileprivate func showProfileTap() {
       
        let profileTintableImage = #imageLiteral(resourceName: "Item 4").withRenderingMode(.alwaysTemplate)
        profileTapImageView.image = profileTintableImage
        profileTapImageView.tintColor = #colorLiteral(red: 0.1412371695, green: 0.7504014373, blue: 0.4530068636, alpha: 1)
        houseTapImageView.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        profileContainerView.isHidden = false
    }
    
    @objc fileprivate func showHouseTap() {
        
        houseTapImageView.tintColor = #colorLiteral(red: 0.1412371695, green: 0.7504014373, blue: 0.4530068636, alpha: 1)
        profileTapImageView.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        profileContainerView.isHidden = true
    }
    
    //collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == foryouCollectionView {
            return questions.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == otherResourceCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foryouCell", for: indexPath) as! ForyouCollectionViewCell
            if recruiters.count > 0 {
                cell.setupRecruiterView(recruiters: recruiters, index: indexPath.item)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foryouCell", for: indexPath) as! ForyouCollectionViewCell
            if questions.count > 0 {
                cell.setupView(questions: questions, index: indexPath.item)
            }
//            if userPreferences.count > 0 {
//                cell.setupPrefView(userPreference: userPreferences, index: indexPath.item, type: type)
//            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 198, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailVC") as! OrganizationDetailViewController
        let recordVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RecordVC") as! RecordViewController
        
        if collectionView == foryouCollectionView {
//            detailVC.userPref = userPreferences[indexPath.item]
//            detailVC.isForyou = true
//            let cell = foryouCollectionView.cellForItem(at: indexPath) as! ForyouCollectionViewCell
//
//
//
//            switch type {
//            case "food":
//                detailVC.imageString = cell.foodImages[indexPath.item]
//            case "counseling":
//                detailVC.imageString = cell.counselingImages[indexPath.item]
//            case "education":
//                detailVC.imageString = cell.educationImages[indexPath.item]
//            case "home":
//                detailVC.imageString = cell.homeImages[indexPath.item]
//            default:
//                detailVC.imageString = cell.transportationImages[indexPath.item]
//            }
//
            recordVC.answer = self.questions[indexPath.item].answer
            recordVC.keywords = self.questions[indexPath.item].keywords as! [String]
            self.present(recordVC, animated: true, completion: nil)
        } else {
            let cell = otherResourceCollectionView.cellForItem(at: indexPath) as! ForyouCollectionViewCell
            detailVC.recruiter = recruiters[indexPath.item]
            detailVC.imageString = cell.images[indexPath.item]
            detailVC.index = indexPath.item
            self.present(detailVC, animated: true, completion: nil)
        }
    }
    
    //Actions
    @IBAction func cookingButtonPressed(_ sender: UIButton) {
        //resetChoiceTap()
        sender.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        userPreferences.removeAll()
        type = "food"
        getUserPreference(category: "food3")
    }
    
    @IBAction func housingButtonPressed(_ sender: UIButton) {
        //resetChoiceTap()
        sender.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        userPreferences.removeAll()
        type = "home"
        getUserPreference(category: "housing0")
    }
    
    @IBAction func transportationButtonPressed(_ sender: UIButton) {
        //resetChoiceTap()
        sender.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        userPreferences.removeAll()
        type = "transportation"
        getUserPreference(category: "transportation2")
    }
    
    @IBAction func counselingButtonPressed(_ sender: UIButton) {
        //resetChoiceTap()
        sender.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        userPreferences.removeAll()
        type = "counseling"
        getUserPreference(category: "counseling4")
    }
    
    @IBAction func educationButtonPressed(_ sender: UIButton) {
        //resetChoiceTap()
        sender.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        userPreferences.removeAll()
        type = "education"
        getUserPreference(category: "education1")
    }
    
    fileprivate func saveInfoToFirestore(question: String) {
        //uid = Auth.auth().currentUser?.uid ?? ""
        let docData: [String: Any] = [
            "answer": "",
            "keywords": [Any](),
            "question": question
        ]
        Firestore.firestore().collection("questions").addDocument(data: docData) { (error) in
            if let error = error {
                print("Fail to add to the database ", error)
                return
            }
            
            self.fetchQuestions { (questions) in
                self.questions = questions
                self.foryouCollectionView.reloadData()
            }
        }
    }
    
    //var newQuestion: Question?
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Question", message: "Type in your question", preferredStyle: .alert)

        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            //print("Text field: \(textField?.text)")
            self.saveInfoToFirestore(question: textField!.text!)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
