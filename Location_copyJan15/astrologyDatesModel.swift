//
//  astrologyDatesModel.swift
//  Location
//
//  Created by Administrator on 12/17/14.
//  Copyright (c) 2014 Vea Software. All rights reserved.
//

import Foundation


class AstrologyClass
{
    

    
    var sunRiseTime: Double;
    var sunSetTime: Double;
    var selectedTime: Double;
    var dayOfWeek: String;
        
    init(sunRiseTime:Double, sunSetTime:Double, selectedTime:Double, dayOfWeek:String) {
        self.sunRiseTime = sunRiseTime;
        self.sunSetTime = sunSetTime;
        self.selectedTime = selectedTime;
        self.dayOfWeek = dayOfWeek;
    }
    func getAstrologyTimes() -> (timeArray: [Double], timeArray1: [Double])
    {

        var riseToSetDifference = sunSetTime - sunRiseTime;
        var partsInMinutes = (riseToSetDifference/8)*60;
        var setToRiseDifference = (24 - sunSetTime) + sunRiseTime;
        var partsSecondInMinutes = (setToRiseDifference/8)*60;
        
        var sunRiseTimeMinute = sunRiseTime*60;
        var sunSetTimeMinute = sunSetTime*60;
        
        var timeArray = [sunRiseTimeMinute,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
        var timeArray1 = [sunSetTimeMinute,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
        
        
        for var index = 1; index < 9; ++index
        {
            
            timeArray[index] = timeArray[index-1] + partsInMinutes;

        }
        for var i = 1; i < 9; ++i
        {
            
            timeArray1[i] = timeArray1[i-1] + partsSecondInMinutes;
            
        }
        
        println("Printed below is the Sunrise to Sunset Array of Minutes");
        println(timeArray);
        println("Printed below is the Sunset to Sunrise Array of Minutes");
        println(timeArray1);
        return (timeArray,timeArray1);
    
    }
    func getReading(dayOfWeek:String) -> String
    {
       
        //LOOK INTO Timezone for GMT
        //Look into Date conversion currently it is still set on day 350

        var readingIndex = getReadingIndex();
        var readingDayDict: [String: Int] = ["Monday": 1, "Saturday": 2, "Thursday":3, "Tuesday":4, "Sunday":5, "Friday":6, "Wednesday":7];
        var readingNightDict: [String: Int] = ["Monday": 1, "Friday": 2, "Tuesday":3, "Saturday":4, "Wednesday":5, "Sunday":6, "Thursday":7]
        var dayArray = ["good","delay","very good", "bad","fight","shopping", "business gain"];
        var nightArray = ["shopping","bad","delay", "gain","fight","very good","good"];
        var workDic: [String: Array] = ["good": ["This is a good time for your professional career, specifically if you have any interview lined up at this time","This is a good time for your professional career, specifically if you have are asking if you a delivering a project"], "delay": ["This is a bad time to be traveling for work, you may experience some traveling delays"], "very good": ["This is a very opportunistic time for anything work related, maybe you should finally ask your boss for that raise at this time!"],"bad/fire": [""],"fight":[""], "shopping":[""], "business gain":[""]];
        
        var educationDic = ["good":[""],"delay":[""], "very good":[""], "bad":[""], "fight":[""], "shopping":[""], "business gain":[""]];
        
        var relationshipDic = ["good":[""],"delay":[""], "very good":[""], "bad":[""], "fight":[""], "shopping":[""], "business gain":[""]];
        
        var travelDic = ["good":[""],"delay":[""], "very good":[""], "bad":[""], "fight":[""], "shopping":[""], "business gain":[""]];
        
        var otherDic = ["good":["This is a moderately good time for any decision or activity"],"delay":["Anything that is done during this period may result in delay", "You may deal with unnecessary annoyances during this period of time"], "very good":[""], "bad":[""], "fight":[""], "shopping":[""], "business gain":[""]];
        var astrologyWord = "";
        var g = (readingDayDict[dayOfWeek]!);
        var p = (readingNightDict[dayOfWeek]!)
        var newReadingIndex: Int = readingIndex.0;
       
   
        
        
        
        
        var astrologyWordIndex =  (newReadingIndex + (readingDayDict[dayOfWeek]!) - 1)%7;
        var astrologyNightIndex = (newReadingIndex + (readingNightDict[dayOfWeek]!) - 1)%7;
        if(readingIndex.1)
        {
            println("inside day array")
            astrologyWord = dayArray[astrologyWordIndex];
            return astrologyWord;
        }
        else
        {
            println("inside night array");
     
            
            
            astrologyWord = nightArray[astrologyNightIndex];
            return astrologyWord;
            
        }
        
        
    
        
        
        
    }
    
    func getReadingIndex() -> (index: Int, boolSun: Bool)
    {
        //reading dictionary should be key val pairs of index and reading
        var readingDictionary = [];
        var astrologyTimes = getAstrologyTimes();
        var sunToSetArray = astrologyTimes.0;
        var setToSunArray = astrologyTimes.1;
        var selectedTimeMinutes = selectedTime;
        
     
   
        if (selectedTime > (60*sunRiseTime) && selectedTime < (60*sunSetTime))
        {
         
            for var index = 0; index < 8; ++index
            {
                if ((sunToSetArray[index]) <= selectedTimeMinutes)
                {
                   
                    if ((sunToSetArray[index+1]) >= selectedTimeMinutes)
                    {
                       
                        return (index, true);
                        
                    }
                    
                    
                }
                
                
            }
            
        }
        else
        {
         

            for var index = 0; index < 8; ++index
            {
                if ((setToSunArray[index]) <= selectedTimeMinutes)
                {
                    if ((setToSunArray[index+1]) >= selectedTimeMinutes)
                    {
                        return (index,false);
                        
                    }
                    
                    
                }
                
                
            }

            
            
        }
        return (-1,false);
    
    }
    
    
        
        
}
