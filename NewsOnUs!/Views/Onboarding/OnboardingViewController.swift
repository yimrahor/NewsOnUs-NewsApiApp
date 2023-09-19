//
//  OnboardingViewController.swift
//  NewsOnUs!
//
//  Created by Yaşar Ebru İmrahor on 5.09.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            }else{
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [OnboardingSlide(title: "CREATE ACCOUNT", description: "You can log in to the application by registering.", image: #imageLiteral(resourceName: "1")), OnboardingSlide(title: "ACCESS TO ALL NEWS", description: "Stay informed about the world", image: #imageLiteral(resourceName: "2")), OnboardingSlide(title: "ADD TO FAVORITES", description: "You can add the news that interests you to your favorites.", image: #imageLiteral(resourceName: "3"))]
        
    }
    
    
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true,completion: nil)
            print("go to the next page")
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

//UICollectionView
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }
      
}
