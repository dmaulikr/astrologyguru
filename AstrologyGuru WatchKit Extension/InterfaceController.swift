//
//  InterfaceController.swift
//  AstrologyGuru WatchKit Extension
//
//  Created by Administrator on 4/1/15.
//  Copyright (c) 2015 DbCom Consulting. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var fd: WKInterfaceImage!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
     
        //
        var newView = UIView(frame: CGRectMake(0, 0, 50, 50))
             newView = FWAnalogClock()
      
        newView.frame = CGRectMake(0.0,0.0,100.0,100.0);
        
//        var image = UIImage(contentsOfFile: "smiley.jpg")
//        fd.setImageNamed("smiley.jpg")
        
        var defaults = NSUserDefaults(suiteName: "group.com.astrologysharing")
        defaults?.setObject("Hello", forKey: "sharing")
        
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    

    


}
