//
//  ViewControllerSecond.swift
//  Location
//
//  Created by Administrator on 1/2/15.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit
import CoreLocation

class ViewControllerSecond: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate,CLLocationManagerDelegate {
    
    var categoryDecision = "Work";
    var categorySecondData = ["Work","Education","Relationship","Travel", "Other"]
    var categorySecondDecision = "Work";
    var categoryEventDecision:String = "";
    var astrologyTimeGiven = "delay";
    var myPredictionResult = "";
    
    @IBOutlet weak var myDate: UIDatePicker!
    
    let locationManager = CLLocationManager()
    var theLatitude = 0.0;
    var theLongitude = 0.0;
    var dayOfYear = 350;
    
    var dayOfWeek = "Monday";
    var subtractDayOfWeek: [String: String] = ["Monday": "Sunday", "Tuesday": "Monday", "Wednesday":"Tuesday", "Thursday":"Wednesday", "Friday":"Thursday", "Saturday":"Friday", "Sunday":"Saturday"];
    var checkedLocation = true;
    
    
    @IBOutlet weak var predictionResult: UITextView!
    
    

    @IBOutlet weak var mySecondCategory: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mySecondCategory.dataSource = self
        mySecondCategory.delegate = self
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        if categorySecondDecision == "Work"
        {
          categoryEventDecision = "Client Meeting";
          categorySecondData = ["Client Meeting","Project Deadline", "Raise Enquiry", "Other"]
            
        }
        if categorySecondDecision == "Education"
        {
            categoryEventDecision = "Exam";
            categorySecondData = ["Exam","Recieving Grades", "Applying to College", "Other" ]
            
        }
        if categorySecondDecision == "Relationship"
        {
            categoryEventDecision = "Wedding Proposal"
            categorySecondData = ["Wedding Proposal","Meeting for Date", "Other"]
            
        }
        if categorySecondDecision == "Travel"
        {
            categoryEventDecision = "Flight Time";
            categorySecondData = ["Flight Time","Leaving House", "Other"]
            
        }
        if categorySecondDecision == "Other"
        {
            categorySecondData = ["Other"]
            
        }
        
        

        // Do any additional setup after loading the view.
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
         
            
            dayOfWeek = subtractDayOfWeek[dayOfWeek]!;
            
            theSelectedMinutes = ((theSelectedMinutes/60)+24)*60;
        }
        
        
     
        
        let rd = AstrologyClass(sunRiseTime:tSun.0,sunSetTime:tSun.1,selectedTime:theSelectedMinutes, dayOfWeek:dayOfWeek);
        
//        var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
//        
//        func update()
//        {
//            
//            println("hh")
//        }
        
        var theReadings = rd.getReading(dayOfWeek);
        astrologyTimeGiven = theReadings;
        println("made it here")
        

        
        var defaults = NSUserDefaults(suiteName: "group.com.astrologysharing")
        defaults?.setObject(theReadings, forKey: "sharing")
        
        //xml parser
        
        var clientMeetingDic: [String: Array<String>] = ["good": ["This is a good time of the week, specifically if you have a client meeting at this time. If you have recurring meetings, this would not be a bad time to set it."], "delay": ["This is a bad time of the week, especially if you have a client meeting. According to the Choghadiya, this a time of delay, which means that you can possibly face unaccounted for problems in arriving to you client meeting on time, so make sure to do things in advance to avoid showing up late!"], "very good": ["This is a very good time according to the Choghadiya Calendar, if you have a client meeting set for this time, this a perfect time to set it."],"bad": ["This is a bad time for any work related tasks. If you have a client meeting at this time I would propose that you change the time you have set your meeting for."],"fight":["According to the Choghadiya Calendar, this is the time of fighting. If you have a client meeting set for this time and you don't want to get in any unnecessary fights/disagreements, I strongly suggest you change your meeting to another time"], "shopping":["According to the Choghadiya Calendar, this is a time for pleasure and fun, so rather than having your client meeting in a windowless, boring room, I recommend that you go somwhere fun, like take everyone out to Sushi!!"], "gain":["According to Choghadiya, this is a time of business gain. If you are trying to make an important business decision during your client meeting this is the time for it. Go For It!!"]];
        
        var projectDeadlineDic: [String: Array<String>] = ["good": ["This is a good time of the week, specifically if you have a project deadline at this time. You will likely have no trouble in meeting this deadline"], "delay": ["This is a bad time of the week, especially if you have a project deadline at this time. According to the Choghadiya Calendar, this a time of delay, which means that you can face unaccounted for problems in meeting your project deadline. Make sure to do things in advance to avoid completing the project late!"], "very good": ["This is a very good time according to the Choghadiya Calendar, if you have a project deadline set for this time, I would not worry to much."],"bad": ["This is a bad time for any work related tasks. If you have a project deadline at this time I would propose that you change the time you have set it"],"fight":["According to the Choghadiya, this is the time of fighting. If you have a project deadline and you are working on a team, be wary of this!"], "shopping":["According to the Choghadiya Calendar, this is a time for pleasure and fun, so if you have a project deadline at this time try and get it done sooner so that during this time you can go somwhere fun, like Karaoke!!"], "gain":["According to Choghadiya, this is a time of business gain. If you are trying to making an important deadline this is the time for it. Dont mess up, and try your best, you will likely have high rewwards!!"]];
        
        var raiseEnquiryDic: [String: Array<String>] = ["good": ["This is a good time of the week, specifically if you want to ask for a raise at this time. You will likely have no trouble with this enquiry"], "delay": ["This is a bad time of the week. According to the Choghadiya, this a time of delay, which means that you can ask for the raise, but the likelihood is that your boss will just delay the entire opportunity!"], "very good": ["This is a very good time according to the Choghadiya Calendar, if you want to ask for that raise, this time would be good for it."],"bad": ["This is a bad time for any work related tasks. If you have to ask your boss for a raise, I would not do it at this time"],"fight":["According to the Choghadiya, this is the time of fighting. If you have to ask for a raise, expect some arguments and push back from your boss!"], "shopping":["According to the Choghadiya Calendar, this is a time for pleasure and fun, so if you want to ask for the raise, try and do it in a more happy and exciting setting, like maybe during cocktail hour at work!!"], "gain":["According to Choghadiya, this is a time of business gain. This is literally the best time of the week to ask for that raise!!"]];
        
        
        var examDic = ["good":["This is a good time of the week, especially if you have an exam at this time."],"delay":["According to the Choghadiya Calendar, this is a time of delay, so it is important that you do not delay studying for this exam, do it in advance."], "very good":["According to the Choghadiya table, this a very good time for your exam, so study hard and things will look good for you"], "bad":["This is a bad time, according to the Choghadiya table, make sure you study hard for this exam, so you don't get a score you don't want"], "fight":["According to the Choghadiya table this is a time of fight, which means be careful not to upset yourself or unnecessarily stress yourself studying for this exam, it can cause unnecessary pain and hassle"], "shopping":["This is a time of pleasure and excitement, make sure after this exam ends you take the chance to really enoy yourself"], "gain":["Doing well on this exam could have a positive effect on your future career according to the predictions of Choghadiya."]];
        
        
        var receivingGradeDic = ["good":["This is a good time of the week, especially if you are recieving a grade at this time."],"delay":["You might experience some lateness or problems when you recieve your grades, be wary of that"], "very good":["According to the Choghadiya table, this a very good time for your exam, so be optimistic about recieving your grades"], "bad":["This is a bad time, according to the Choghadiya table, make sure you are prepared when you recieve your grades"], "fight":["This is a bad time, according to the Choghadiya table, make sure you are prepared when you recieve your grades"], "shopping":["This is a time of pleasure and excitement, make sure that after your recieve you grades you take the chance to really enoy yourself"], "gain":["Doing well on this exam could have a positive effect on your future career according to the predictions of Choghadiya."]];
        
        
        var applyCollegeDic = ["good":["This is a good time of the week, especially if you want to send an application for college."],"delay":["According to the Choghadiya table, this is a time of delay, so it is important that you do not delay applying for college, do it in advance."], "very good":["According to the Choghadiya table, this a very good, so make sure to send your applications out at this time"], "bad":["This is a bad time, according to the Choghadiya table, I would recommend not to send your application out at this time"], "fight":["This is a bad time, according to the Choghadiya table, I would recommend not to send your application out at this time"], "shopping":["This is a good time of the week, especially if you want to send an application for college."], "gain":["This is a good time of the week, especially if you want to send an application for college."]];
        
        
        
        var weddingProposalDic = ["good":["This is a good time of the week, especially if you want to propose at this time"],"delay":["According to the Choghadiya table, this is a time of delay, so it might not be best to propose at this time, because it might lead to delay."], "very good":["According to the Choghadiya table, this a very good time, especially if you want to propose at this time"], "bad":["This is a bad time, according to the Choghadiya table, I would recommend not to propose at this time"], "fight":["According to the Choghadiya, this is a time of fighting, so I advise you to be careful not to propose at this time, it may lead to unnecessary fights and not give you the response that you truly want."], "shopping":["This is a good time of the week, especially if you want to propose at this time, it will lead to a happy marriage"], "gain":["This is a time of business gain according to the Choghadiya, proposing at this time will lead a happy/wealthy marriage."]];
        
        var meetingForDateDic = ["good":["This is a good time of the week, especially if you want to go on your date at this time"],"delay":["According to the Choghadiya table, this is a time of delay, so it might not be best to ask anyone out/have a date at this time, because it might lead to delay."], "very good":["According to the Choghadiya table, this is a very good time, especially if you want to propose at this time"], "bad":["This is a bad time, according to the Choghadiya table, I would recommend not to propose at this time"], "fight":["According to the Choghadiya, this is a time of fighting, so I advise you to be careful not to have a date at this time, it may lead to unnecessary fights and not give you the response that you truly want."], "shopping":["This is a good time of the week, especially if it is to have a date. This is the time of pleasure and fun!!"], "gain":["This is a good time of the week, especially if you want to go on your date at this time."]];
        
        
        
        
        var flightTimeDic = ["good":["This is a good time of the week, if you are thinking of buying a flight at this time."],"delay":["Be Careful! This is the time of delay according to the Choghadiya Calendar, if you buy a flight at this time you might have to deal with unaccounted for delays"], "very good":["This is a very good time of the week, if you are thinking of buying a flight at this time, it is a good choice."], "bad":["This is a bad time of the week, if you are thinking of buying a flight at this time, I would recommend choosing another time."], "fight":["According to Choghadiya, this is a bad time of the week, if you are thinking of buying a flight at this time, it is a bad idea, I would recommend choosing another time."], "shopping":["This is a time of pleasure, so if you are buying a flight ticket to a vacation spot, this is a perfect time for it."], "gain":["According to the Choghadiya, this is a good time, specifically as it relates to business gain, so if you are traveling for a reason related to business, than make sure your flight is at this time"]];
        
        
        var leavingHouseDic = ["good":["This is a good time of the week, if you are thinking of traveling/leaving your house, it is not a bad time."],"delay":["Be Careful! This is the time of delay according to the Choghadiya Calendar, if you are planning on traveling at this time you might have to deal with unaccounted for delays"], "very good":["This is a very good time of the week, if you are thinking of traveling/leaving your house, it is not a bad time."], "bad":["This is a bad time of the week, if you are thinking of traveling at this time, I would recommend choosing another time."], "fight":["According to the Choghadiya Calendar, this is a time of fight, so I advise that if you do leave your house at this time, you avoid any potential reasons for conflict!"], "shopping":["According to the Choghadiya, this a time of pleasure, so if you are leaving your house at this time and are going out with friends or family, expect to have a good time!"], "gain":["According to the Choghadiya Calendar, this is a good time, specifically as it relates to business gain, so if you are traveling for a reason related to business, than make sure it is at this time"]];
        
        var otherDic = ["good":["This is a good time of the week, any decision that you want to make at this time will likely have good results."],"delay":["Be Careful! This is the time of delay according to the Choghadiya Calendar, if you are making any decisions at this time you might have to deal with unaccounted for delays"], "very good":["This is a very good time of the week, if you are thinking of making any decisions that are at this time it is not a bad time."], "bad":["This is a bad time of the week, if you are thinking of traveling at this time, I would recommend choosing another time."], "fight":["According to the Choghadiya Calendar, this is a time of fight, so I advise that if you are making any decisions at this time, you avoid any potential reasons for conflict!"], "shopping":["According to the Choghadiya, this is a time of pleasure, so if you are planning on making any decision at this time, don't forget this!"], "gain":["According to the Choghadiya Calendar, this is a time of business gain, so if you want to make any financial or money related decision, this is the time for it."]];
        
        
       //switch statement here
        
        
        if(categoryEventDecision == "Client Meeting")
        {
            
            myPredictionResult = clientMeetingDic[astrologyTimeGiven]![0];
            
        }
        else if(categoryEventDecision == "Project Deadline")
        {
 
            myPredictionResult = projectDeadlineDic[astrologyTimeGiven]![0];
            
        }
        else if(categoryEventDecision == "Raise Enquiry")
        {
            myPredictionResult = raiseEnquiryDic[astrologyTimeGiven]![0];
            
        }
        else if(categoryEventDecision == "Exam")
        {
            myPredictionResult = examDic[astrologyTimeGiven]![0];
            
        }
        else if(categoryEventDecision == "Recieving Grades")
        {
            myPredictionResult = receivingGradeDic[astrologyTimeGiven]![0];
            
        }
        else if(categoryEventDecision == "Applying to College")
        {
            myPredictionResult = applyCollegeDic[astrologyTimeGiven]![0];
            
        }
        else if(categoryEventDecision == "Wedding Proposal")
        {
           myPredictionResult = weddingProposalDic[astrologyTimeGiven]![0];
            
        }
        else if(categoryEventDecision == "Meeting for Date")
        {
            myPredictionResult = meetingForDateDic[astrologyTimeGiven]![0];
            
        }
        else if(categoryEventDecision == "Flight Time")
        {
            myPredictionResult = flightTimeDic[astrologyTimeGiven]![0];
            
        }
        else if(categoryEventDecision == "Leaving House")
        {
            myPredictionResult = leavingHouseDic[astrologyTimeGiven]![0];
            
        }
        else
        {
            myPredictionResult = otherDic[astrologyTimeGiven]![0];
        }
      
        
        
        var thirdVC: thirdAgainViewController = segue.destinationViewController as thirdAgainViewController;
        thirdVC.getResponse = myPredictionResult;
        
        
        
        
    }
    
    @IBAction func getPrediction(sender: AnyObject) {

    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorySecondData.count
    }
    
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categorySecondData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        categoryEventDecision =  categorySecondData[row]

    }
    
 
    
    func getSunriseSunset() -> (theSunset: Double, theSunrise: Double) {
        
        let tipCalc = testSunrise(latitude:theLatitude, longitude: theLongitude);
        var theSunrise = tipCalc.computeNSunrise(Double(dayOfYear),sunrise: true);
        var theSunset = tipCalc.computeNSunrise(Double(dayOfYear), sunrise: false);
        
        return (theSunrise,theSunset);
        
        
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        
        var currentLocation : CLLocation = locations[0] as CLLocation
        
        theLatitude = currentLocation.coordinate.latitude;
        theLongitude = currentLocation.coordinate.longitude;
        
        
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

        
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }


    @IBAction func presentDate(sender: AnyObject) {
        
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: myDate.date)
        let ahour = components.hour
        let aminutes = components.minute
        var timeFormatter = NSDateFormatter();
        timeFormatter.dateFormat = "EEEE";
        dayOfWeek = timeFormatter.stringFromDate(myDate.date);
     
    }
    



}
