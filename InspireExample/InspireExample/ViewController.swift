//
//  ViewController.swift
//  InspireExample
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit
import Inspire

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
    
    let mask = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let ipr = Inspire.current
        
        print("RootVC.safeAreaInsets: \(ipr.layout.safeAreaInsets(for: ipr.rootVC ?? self))")
        print("self.safeAreaInsets: \(Inspire.shared.layout.safeAreaInsets(for: self))")
        
        print("-----screen:")
        print("safeAreaInsets", ipr.screen.safeAreaInsets)
        print("bounds", ipr.screen.bounds)
        print("navBar", ipr.screen.navBar)
        print("statusBar", ipr.screen.statusBar)
        print("topBar", ipr.screen.topBar)
        print("tabBar", ipr.screen.tabBar)
        print("bottomBar", ipr.screen.bottomBar)
        
        print("-----")
//        print(ipr.)
        
        mask.backgroundColor = .init(white: 0.9, alpha: 1)
        let safeAreaInsets = Inspire.shared.screen.safeAreaInsets
        print(safeAreaInsets)
        mask.frame = .init(x: safeAreaInsets.left, y: safeAreaInsets.top, width: view.bounds.width - safeAreaInsets.left - safeAreaInsets.right, height: view.bounds.height - safeAreaInsets.top - safeAreaInsets.bottom)
        view.insertSubview(mask, at: 0)
        
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = NewVC()
        vc.view.backgroundColor = .white
        
        
        present(vc, animated: true, completion: nil)
    }

}

