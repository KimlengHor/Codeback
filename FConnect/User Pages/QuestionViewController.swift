//
//  QuestionViewController.swift
//  FConnect
//
//  Created by hor kimleng on 11/2/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import UIKit
import Firebase

class QuestionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, QuestionButtonsDelegate {

    //IBOutlets
    @IBOutlet weak var questionCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //Variables
    var answerOptionArray = [Bool]()
    var isSignup = false
    var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    fileprivate func setupView() {
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
        questionCollectionView.isPagingEnabled = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / self.view.frame.width)
    }
    
    fileprivate func saveQuestionToFirestore() {
        
        let docData: [String: Any] = [
            "questionAnswer": answerOptionArray
        ]
        
        Firestore.firestore().collection("users").document(uid).updateData(docData) { (error) in
            if let error = error {
                print(error)
                return
            }
        }
        
    }
    
    //collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "questionCell", for: indexPath) as! QuestionCollectionViewCell
        cell.setupView(index: indexPath.item)
        cell.questionDelegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func buttonTapped(index: IndexPath, choice: Bool) {
        if index.item < 4 {
            questionCollectionView.scrollToItem(at: IndexPath(item: index.item + 1, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = index.item + 1
            
            if choice {
                answerOptionArray.append(true)
            } else {
                answerOptionArray.append(false)
            }
        } else {
            
            if choice {
                answerOptionArray.append(true)
            } else {
                answerOptionArray.append(false)
            }
            
            print(answerOptionArray)
            
            if isSignup {
                saveQuestionToFirestore()
                let discoverNavigationVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DiscoverNavigationVC") 
                discoverNavigationVC.modalPresentationStyle = .fullScreen
                self.present(discoverNavigationVC, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.questionCollectionView.frame.width, height: self.questionCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
