//
//  NewVC.swift
//  InspireExample
//
//  Created by xaoxuu on 2020/6/22.
//  Copyright © 2020 Titan Studio. All rights reserved.
//

import UIKit

class NewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 20, y: 20, width: 100, height: 100)
        btn.setTitle("dismiss", for: .normal)
        btn.addTarget(self, action: #selector(self.dismiss(_:)), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let mask = UIView()
        mask.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        let safeAreaInsets = ipr.layout.safeAreaInsets(for: self)
        print(safeAreaInsets)
        mask.frame = .init(x: safeAreaInsets.left, y: safeAreaInsets.top, width: view.bounds.width - safeAreaInsets.left - safeAreaInsets.right, height: view.bounds.height - safeAreaInsets.top - safeAreaInsets.bottom)
        view.insertSubview(mask, at: 0)
    }

    
    
}
