//
//  ViewControllerSecond.swift
//  Location
//
//  Created by Administrator on 1/2/15.
//  Copyright (c) 2015 Vea Software. All rights reserved.
//

import UIKit

class ViewControllerSecond: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    
       var categorySecondData = ["Work","Education","Relationship","Travel", "Other"]
       var categorySecondDecision = "Work";
    var categoryEventDecision:String = "";
       var astrologyTimeGiven = "delay";
    var myPredictionResult = "";
    
    
    @IBOutlet weak var predictionResult: UITextView!
    
    

    @IBOutlet weak var mySecondCategory: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mySecondCategory.dataSource = self
        mySecondCategory.delegate = self
        println("I am about to print changed value");
        println(categorySecondDecision);
        println(" I am about to print astrology time given");
        println(astrologyTimeGiven);
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
        
        
        
        var clientMeetingDic: [String: Array<String>] = ["good": ["This is a good time of the week, specifically if you have a client meeting at this time. If you have recurring meetings, this would not be a bad time to set it"], "delay": ["This is a bad time of the week, especially if you have a Client Meeting. According to the Chogadiya, this a time of delay, which means that you can face unaccounted for problems in arriving to you client meeting on time, make sure to do things in advance to avoid showing up late!"], "very good": ["This is a very good time according to the Chogadiya Calendar, if you have a Client Meeting set for this time, this a perfect time to set it."],"bad": ["This is a bad time for any work related tasks. If you have a client meeting at this time I would propose that you change the time you have set it"],"fight":["According to the Chogadiya, this is the time of fighting. If you have a client meeting set for this time and you don't want to get in unnecessary fights/disagreements, I strongly suggest you change your meeting to another time"], "shopping":["According to the Chogadiya Calendar, this is a time for pleasure and fun, so rather than having your client meeting in a windowless, boring room, I recommend that you go somwhere fun, like take everyone out to Sushi!!"], "business gain":["According to Chogadiya, this is a time of Business Gain. If you are trying to making an important business decision during your client meeting this is the time for it. Go For It!!"]];
        
        var projectDeadlineDic: [String: Array<String>] = ["good": ["This is a good time of the week, specifically if you have a project deadline at this time. You will likely have no trouble in meeting this deadline"], "delay": ["This is a bad time of the week, especially if you have a Project Deadline. According to the Chogadiya, this a time of delay, which means that you can face unaccounted for problems in meeting your project deadline. Make sure to do things in advance to avoid completing the project late!"], "very good": ["This is a very good time according to the Chogadiya Calendar, if you have a Project Deadline set for this time, I would not worry to much."],"bad": ["This is a bad time for any work related tasks. If you have a project deadline at this time I would propose that you change the time you have set it"],"fight":["According to the Chogadiya, this is the time of fighting. If you have a project deadline and you are working on a team, be wary of this!"], "shopping":["According to the Chogadiya Calendar, this is a time for pleasure and fun, so if you have a project deadline at this time try and get it done sooner so that during this time you can go somwhere fun, like Karaoke!!"], "business gain":["According to Chogadiya, this is a time of Business Gain. If you are trying to making an important deadline this is the time for it. Dont mess up, and try your best, you will likely have high rewwards!!"]];
        
        var raiseEnquiryDic: [String: Array<String>] = ["good": ["This is a good time of the week, specifically if you want to as for a raise at this time. You will likely have no trouble with this enquiry"], "delay": ["This is a bad time of the week. According to the Chogadiya, this a time of delay, which means that you can ask for the raise, but the likelihood is that your boss will just delay the entire opportunity!"], "very good": ["This is a very good time according to the Chogadiya Calendar, if you want to ask for that raise, this time would be good."],"bad": ["This is a bad time for any work related tasks. If you have to ask your buss for a raise, I would not do it at this time"],"fight":["According to the Chogadiya, this is the time of fighting. If you have to ask for a raise, expect some arguments and push back from your boss!"], "shopping":["According to the Chogadiya Calendar, this is a time for pleasure and fun, so if you want to ask for the raise, try and do it in a more happy and exciting setting, like maybe during cocktail hour at work!!"], "business gain":["According to Chogadiya, this is a time of Business Gain. This is literally the best time of the week to ask for that raise!!"]];
        
        
        var examDic = ["good":["This is a good time of the week, especially if you have an exam this time."],"delay":["According to the Chogadiya table, this is a time of delay, so it is important that you do not delay your studying for this exam, do it in advance."], "very good":["According to the Chogadiya table, this a very good time for your exam, so study hard and things are looking good for you"], "bad":["This is a bad time, according to the Chogadiya table, make sure you study hard for this exam, so you don't get a score you don't want"], "fight":["According to the Chogadiya table this is a tiem of fight, which means be careful not to upset yourself or unnecessarily stress yourself studying for this exam, it can cause unnecessary pain and hassle"], "shopping":["This is a time of pleasure and excitement, make sure after this exam ends you take the chance to really enoy yourself"], "business gain":["Doing well on this exam could have a positive effect on your future career according to the predictions of Chogadiya."]];
        
        
        var receivingGradeDic = ["good":["This is a good time of the week, especially if you have are recieving a grade at this time."],"delay":["You might experience some lateness or problems when you recieve your grades, be wary of that"], "very good":["According to the Chogadiya table, this a very good time for your exam, so be optimistic about recieving your grades"], "bad":["This is a bad time, according to the Chogadiya table, make sure you are prepared when you recieve your grades"], "fight":["This is a bad time, according to the Chogadiya table, make sure you are prepared when you recieve your grades"], "shopping":["This is a time of pleasure and excitement, make sure after this your recieve you grades you take the chance to really enoy yourself"], "business gain":["Doing well on this exam could have a positive effect on your future career according to the predictions of Chogadiya."]];
        
        
        var applyCollegeDic = ["good":["This is a good time of the week, especially if you want to send an application for college."],"delay":["According to the Chogadiya table, this is a time of delay, so it is important that you do not delay applying for college, do it in advance."], "very good":["According to the Chogadiya table, this a very good, so make to send your applications out at this time"], "bad":["This is a bad time, according to the Chogadiya table, I would recommend not to send your application out at this time"], "fight":["This is a bad time, according to the Chogadiya table, I would recommend not to send your application out at this time"], "shopping":["This is a good time of the week, especially if you want to send an application for college."], "business gain":["This is a good time of the week, especially if you want to send an application for college."]];
        
        
        
        var weddingProposalDic = ["good":["This is a good time of the week, especially if you want to propose at this time"],"delay":["According to the Chogadiya table, this is a time of delay, so it might not be best to propose at this time, because it might lead to delay."], "very good":["According to the Chogadiya table, this a very good time, especially if you want to propose at this time"], "bad":["This is a bad time, according to the Chogadiya table, I would recommend not to propose at this time"], "fight":["According to the Chogadiya, this is a time of fighting, so I advise you to be careful not to propose at this time, it may lead to unnecessary fights and not give you the response that you truly want."], "shopping":["This is a good time of the week, especially if you want to propose at this time, it will lead to happy marriage"], "business gain":["This is a time of business gain according to the Chogadiya, proposing at this time will lead a happy/wealthy marriage."]];
        
        var meetingForDateDic = ["good":["This is a good time of the week, especially if you want to go on your date at this time"],"delay":["According to the Chogadiya table, this is a time of delay, so it might not be best to ask anyone out/have a date at this time, because it might lead to delay."], "very good":["According to the Chogadiya table, this a very good time, especially if you want to propose at this time"], "bad":["This is a bad time, according to the Chogadiya table, I would recommend not to propose at this time"], "fight":["According to the Chogadiya, this is a time of fighting, so I advise you to be careful not to have a date at this time, it may lead to unnecessary fights and not give you the response that you truly want."], "shopping":["This is a good time of the week, especially if it is to have a date. This is the time of pleasure and fun!!"], "business gain":["This is a good time of the week, especially if you want to go on your date at this time."]];
        
        
        
        
        var flightTimeDic = ["good":["This is a good time of the week, if you are thinking of buying a flight at this time, it is a good choice."],"delay":["Be Careful! This is the time of delay according to the chogadiya, if you buy a flight at this time you might have to deal with unaccounted for delays"], "very good":["This is a very good time of the week, if you are thinking of buying a flight at this time, it is a good choice."], "bad":["This is a bad time of the week, if you are thinking of buying a flight at this time, it is a bad idea, I would recommend choosing another time."], "fight":["According to Chogadiya, this is a bad time of the week, if you are thinking of buying a flight at this time, it is a bad idea, I would recommend choosing another time."], "shopping":["This is a time of pleasure, so if you are buying a flight ticket to a vacation spot, this is perfect."], "business gain":["According to the Chogadiya, this is a good time, specifically as it relates to business gain, so if you are traveling for a reason related to business, than make sure it is at this time"]];
        
        
        var leavingHouseDic = ["good":["This is a good time of the week, if you are thinking of traveling/leaving your house, its not bad."],"delay":["Be Careful! This is the time of delay according to the chogadiya, if you are planning on traveling at this time you might have to deal with unaccounted for delays"], "very good":["This is a very good time of the week, if you are thinking of traveling/leaving your house, its not bad."], "bad":["This is a bad time of the week, if you are thinking of traveling at this time, it is a bad idea, I would recommend choosing another time."], "fight":["According to the Chogadiya, this is a time of fight, so I advise that if you do leave your house at this time, you avoid any potential reasons for conflict!"], "shopping":["According to the Chogadiya, this a time of pleasure, so if you are leaving your house at this time and are going out with friends or family, expect to have a good time!"], "business gain":["According to the Chogadiya, this is a good time, specifically as it relates to business gain, so if you are traveling for a reason related to business, than make sure it is at this time"]];
        
        var otherDic = ["good":["This is a good time of the week, any decision that you want to make at this time will likely have good results."],"delay":["Be Careful! This is the time of delay according to the chogadiya, if you are making any decisions at this time you might have to deal with unaccounted for delays"], "very good":["This is a very good time of the week, if you are thinking of making any decisions that are at this time its not a bad."], "bad":["This is a bad time of the week, if you are thinking of traveling at this time, it is a bad idea, I would recommend choosing another time."], "fight":["According to the Chogadiya, this is a time of fight, so I advise that if you are making any decisions at this time, you avoid any potential reasons for conflict!"], "shopping":["According to the Chogadiya, this is a time of pleasure, so if you are planning on making any decision at this time, don't forget this!"], "business gain":["According to the Chogadiya, this is a time of business gain, so if you want to make any financial or money related decision, this is the time for it."]];
        
        
        
        
        
        if(categoryEventDecision == "Client Meeting")
        {
            myPredictionResult = clientMeetingDic[astrologyTimeGiven]![0];
            
        }
        else if(categoryEventDecision == "Project Deadline")
        {
            println(categoryEventDecision);
            println(categorySecondDecision);
            println(astrologyTimeGiven);
            println("fdsfds");
            
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
      
        
        
        var thirdVC: thirdViewController = segue.destinationViewController as thirdViewController;
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
        println("Printing Category Decision");
        println(categorySecondDecision);
    }


    



}
