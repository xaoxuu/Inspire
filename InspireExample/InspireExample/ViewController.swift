//
//  ViewController.swift
//  InspireExample
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit
import Inspire
import AXKit

class ViewController: UIViewController {

    @IBOutlet weak var title11: UILabel!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    
    @IBOutlet weak var title3: UILabel!
    
    @IBOutlet weak var headline: UILabel!
    
    @IBOutlet weak var subhead: UILabel!
    
    @IBOutlet weak var footnote: UILabel!
    
    @IBOutlet weak var body: UILabel!
    
    @IBOutlet weak var callout: UILabel!
    
    @IBOutlet weak var caption1: UILabel!
    
    @IBOutlet weak var caption2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        for str in UIFont.familyNames {
//            print(UIFont.fontNames(forFamilyName: str))
//        }
//        view.backgroundColor = UIColor.failure
        Inspire.restore("theme")
        
        view.backgroundColor = Inspire.current.color.background
        
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        Inspire.current.color.failure = UIColor.lightGray
//        view.backgroundColor = UIColor.failure
        
//        print(Inspire.current.layout.safeAreaInsets)
//        print(Inspire.current.layout.updatedSafeAreaInsets)
//        print(Inspire.current.layout.safeAreaInsets)
        
        view.backgroundColor = Inspire.current.color.background
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            Inspire.current.color.background = Inspire.current.color.accent
            Inspire.current.cache(named: "theme")
            self.view.backgroundColor = Inspire.current.color.background
        }
    }

}

