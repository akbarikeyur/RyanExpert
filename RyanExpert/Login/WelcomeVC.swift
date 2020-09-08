//
//  WelcomeVC.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 03/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var introCV: UICollectionView!
    @IBOutlet weak var introPageControl: UIPageControl!
    
    var arrIntroData = [IntroModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCollectionView()
        if isNotFirstTime() {
            AppDelegate().sharedDelegate().navigateToLogin()
        }
    }
    
    //MARK:- Button click event
    @IBAction func clickToSkip(_ sender: Any) {
        setNotFirstTime(true)
        AppDelegate().sharedDelegate().navigateToLogin()
    }
    
    @IBAction func clickToNext(_ sender: Any) {
        if introPageControl.currentPage == (arrIntroData.count-1) {
            setNotFirstTime(true)
            AppDelegate().sharedDelegate().navigateToLogin()
        }else{
            introCV.scrollToItem(at: IndexPath(row: introPageControl.currentPage+1, section: 0), at: .right, animated: true)
        }
    }

}

//MARK:- CollectionView Method
extension WelcomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func registerCollectionView() {
        introCV.register(UINib.init(nibName: "WelcomeCVC", bundle: nil), forCellWithReuseIdentifier: "WelcomeCVC")
        
        arrIntroData = [IntroModel]()
        let arrTempData = getJsonFromFile("intro")
        for temp in arrTempData {
            arrIntroData.append(IntroModel.init(dict: temp))
        }
        introPageControl.numberOfPages = arrIntroData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrIntroData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : WelcomeCVC = introCV.dequeueReusableCell(withReuseIdentifier: "WelcomeCVC", for: indexPath) as! WelcomeCVC
        let dict = arrIntroData[indexPath.row]
        cell.titleLbl.text = dict.title
        cell.subTitleLbl.text = dict.subTitle
        cell.imgBtn.setImage(UIImage(named: dict.image), for: .normal)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.introCV.contentOffset, size: self.introCV.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.introCV.indexPathForItem(at: visiblePoint) {
            self.introPageControl.currentPage = visibleIndexPath.row
        }
    }
}
