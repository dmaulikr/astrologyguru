//
//  thirdAgainViewController.swift
//  Location
//
//  Created by Administrator on 1/21/15.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit

class thirdAgainViewController: UIViewController {
    var getResponse = "";

    @IBOutlet weak var textResult: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addResponse(sender: AnyObject) {
        textResult.text = getResponse;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
