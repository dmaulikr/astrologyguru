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
    let categoryData = ["Work","Education","Relationship","Travel", "Other"]
    
    let locationManager = CLLocationManager()

  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCategory.dataSource = self
        myCategory.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        

        var secondVC: ViewControllerSecond = segue.destinationViewController as ViewControllerSecond
        
        secondVC.categorySecondDecision = categoryDecision;
        
      
    }
    

   

    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryData.count
    }
    
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categoryData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        categoryDecision =  categoryData[row]

}


  


   
    
    }

