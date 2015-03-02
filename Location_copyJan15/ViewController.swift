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
    
    @IBOutlet var myDate: UIDatePicker!
    @IBOutlet weak var myTextBox: UITextView!
    @IBOutlet weak var myCategory: UIPickerView!
    var categoryDecision = "Work";
    let categoryData = ["Work","Education","Relationship","Travel", "Other"]
    
    let locationManager = CLLocationManager()
    var theLatitude = 0.0;
    var theLongitude = 0.0;
    var checkTheL = 0.0;
    var checkTheLA = 0.0;
    var dayOfYear = 350;
    
    var dayOfWeek = "Monday";
    var subtractDayOfWeek: [String: String] = ["Monday": "Sunday", "Tuesday": "Monday", "Wednesday":"Tuesday", "Thursday":"Wednesday", "Friday":"Thursday", "Saturday":"Friday", "Sunday":"Saturday"];
    var checkedLocation = true;
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCategory.dataSource = self
        myCategory.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        presentDate(myDate);
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: myDate.date)
        let ahour = components.hour
        let aminutes = components.minute
        
        var theSelectedMinutes = Double((ahour*60)+aminutes);
        var tSun = getSunriseSunset();
        
        if (theSelectedMinutes < (tSun.0 * 60))
        {
            //look into integer division cutting off many minutes
            //division cutting full hour
            //issue is that it is double so 183/60 = 3
          
            dayOfWeek = subtractDayOfWeek[dayOfWeek]!;
            
            theSelectedMinutes = ((theSelectedMinutes/60)+24)*60;
        }
        
        
        
        
        let rd = AstrologyClass(sunRiseTime:tSun.0,sunSetTime:tSun.1,selectedTime:theSelectedMinutes, dayOfWeek:dayOfWeek);
        
        
        var theReadings = rd.getReading(dayOfWeek);
    
        

        
        var secondVC: ViewControllerSecond = segue.destinationViewController as ViewControllerSecond
        
        secondVC.categorySecondDecision = categoryDecision;
        secondVC.astrologyTimeGiven = theReadings;
      
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        

        var currentLocation : CLLocation = locations[0] as CLLocation
        
//        if (currentLocation){

            theLatitude = currentLocation.coordinate.latitude;
            theLongitude = currentLocation.coordinate.longitude;
            
//        }
        
        if (checkedLocation)
        {
            checkedLocation = false;
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Error: " + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
              }   else {
                  println("Error with the data.")
              }
          })
        }
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        
        self.locationManager.stopUpdatingLocation()
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
    func getSunriseSunset() -> (theSunset: Double, theSunrise: Double) {
        println("I am in getSunriseSet");
        println(theLatitude);
        println(theLongitude);
        println(dayOfYear);

    
        
        let tipCalc = testSunrise(latitude:theLatitude, longitude: theLongitude);
        var theSunrise = tipCalc.computeNSunrise(Double(dayOfYear),sunrise: true);
        var theSunset = tipCalc.computeNSunrise(Double(dayOfYear), sunrise: false);

        return (theSunrise,theSunset);
    
        
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
        println("Printing Category Decision");
        println(categoryDecision);
}


    @IBAction func presentDate(sender: AnyObject) {
      
        //Will need to create further abstractions later
        
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: myDate.date)
        let ahour = components.hour
        let aminutes = components.minute
       
        
       
        var timeFormatter = NSDateFormatter();
        timeFormatter.dateFormat = "EEEE";
        dayOfWeek = timeFormatter.stringFromDate(myDate.date);
        println(dayOfWeek);

        

    }


   
    
    }

