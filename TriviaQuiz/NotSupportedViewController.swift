//
//  NotSupportedViewController.swift
//  TriviaQuiz
//
//  Created by Melle Meewis on 14/12/2018.
//  Copyright © 2018 Melle Meewis. All rights reserved.
//

import UIKit

class NotSupportedViewController: UIViewController {

    
    @IBOutlet weak var tryAgainButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tryAgainButton.layer.cornerRadius = 5.0

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
