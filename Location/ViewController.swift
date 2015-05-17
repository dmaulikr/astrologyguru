//
//  ViewController.swift
//  Location
//
//  Created by PJ Vea on 10/18/14.
//  Copyright (c) 2014 Vea Software. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate, CLLocationManagerDelegate {
    

    @IBOutlet weak var myTextBox: UITextView!
    @IBOutlet weak var myCategory: UIPickerView!
    var categoryDecision = "Work";
    let categoryData = ["Work","Education","Relationship","Travel", "Othr"]
    var categoryData1 = ["","","","","", "", "", ""]
    
    let locationManager = CLLocationManager()

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCategory.dataSource = self
        myCategory.delegate = self
        println("lala")
        
        var query = PFQuery(className:"ConcernCategory")
//        query.whereKey("Job", equalTo:"General")
        query.whereKeyExists("Job")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
//            var categoryData1: NSMutableArray = NSMutableArray(capacity: objects!.count)

            
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects!.count) scores.")
//                var categoryData1: NSMutableArray = NSMutableArray(capacity: objects!.count)
                var count = 0
                //                var theArray = objects!.count * ["asdf"]
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectId)
//                        self.categoryData1.append = "asdf"
                        
//                        self.categoryData1[count] = object.objectId!
                        self.categoryData1[count] = object["Job"] as! String
                        count = count + 1
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        

        var secondVC: ViewControllerSecond = segue.destinationViewController as! ViewControllerSecond
        
        secondVC.categorySecondDecision = categoryDecision;
        
      
    }
    

   

    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryData1.count
    }
    
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categoryData1[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {


        
        categoryDecision =  categoryData1[row]

}


  


   
    
    }

