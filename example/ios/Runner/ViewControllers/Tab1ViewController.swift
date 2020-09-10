//
//  Tab1ViewController.swift
//  Runner
//
//  Created by gix on 2020/9/2.
//

import UIKit
import g_faraday

class Tab1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func openFlutterDemo(sender: UIButton) {
        
        let vc = FPage.home.flutterViewController { r in
            sender.setTitle("result from flutter \(r ?? "none")", for: .normal)
        }
        
        navigationController?.pushViewController(vc, animated: true);
        
    }

}
