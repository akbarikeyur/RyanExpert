//
//  CustomTabBarView.swift
//  Event Project
//
//  Created by Amisha on 20/07/17.
//  Copyright © 2017 AK Infotech. All rights reserved.
//

import UIKit

protocol CustomTabBarViewDelegate
{
    func tabSelectedAtIndex(index:Int)
}

class CustomTabBarView: UIView {
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    
    var delegate:CustomTabBarViewDelegate?
    var lastIndex : NSInteger!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize()
    {
        lastIndex = 0
    }
    
    @IBAction func tabBtnClicked(_ sender: UIButton)
    {
        let btn: UIButton = sender
        if btn.tag == 1 {
            delegate?.tabSelectedAtIndex(index: 0)
            return
        }
        lastIndex = btn.tag - 1
        
        resetAllButton()
        selectTabButton()
        
    }
    
    func resetAllButton()
    {
        btn1.tintColor = LightTextColor
        btn2.tintColor = LightTextColor
        btn3.tintColor = LightTextColor
        btn4.tintColor = LightTextColor
    }
    
    func selectTabButton()
    {
        switch lastIndex {
            case 0:
                btn1.tintColor = GreenColor
                break
            case 1:
                btn2.tintColor = GreenColor
                break
            case 2:
                btn3.tintColor = GreenColor
                break
            case 3:
                btn4.tintColor = GreenColor
                break
            default:
                break
        }
        delegate?.tabSelectedAtIndex(index: lastIndex)
    }
}
