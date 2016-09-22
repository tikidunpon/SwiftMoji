//
//  ViewController.swift
//  SwiftMoji
//
//  Created by koichi on 04/14/2016.
//  Copyright (c) 2016 koichi. All rights reserved.
//

import UIKit
import SwiftMoji

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let snakeCased = "UserId".snakecased()
        print(snakeCased)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

