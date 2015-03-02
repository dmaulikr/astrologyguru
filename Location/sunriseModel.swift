//
//  sunriseModel.swift
//  Location
//


import Darwin
import Foundation


class testSunrise
{
    
    
    var latitude: Double;
    var longitude: Double;
   
    
    init(latitude:Double, longitude:Double) {
        self.latitude = latitude;
        self.longitude = longitude;
        
    }
    
    func computeNSunrise(day: Double, sunrise: Bool) -> Double  {
        
        

        var zenith = 90.83333333333333;
        var D2R = M_PI / 180;
        var R2D = 180 / M_PI;
        
        // convert the longitude to hour value and calculate an approximate time
        var lnHour = longitude / 15;
        
        var t = day + ((6 - lnHour) / 24);
        if (sunrise == false) {
            t = day + ((18 - lnHour) / 24);
        };
        
        //calculate the Sun's mean anomaly
        var M = (0.9856 * t) - 3.289;
        
        //calculate the Sun's true longitude
        var L = M + (1.916 * sin(M * D2R)) + (0.020 * sin(2 * M * D2R)) + 282.634;
        if (L > 360) {
            L = L - 360;
        } else if (L < 0) {
            L = L + 360;
        };
        
        //calculate the Sun's right ascension
        var RA = R2D * atan(0.91764 * tan(L * D2R));
        if (RA > 360) {
            RA = RA - 360;
        } else if (RA < 0) {
            RA = RA + 360;
        };
        
        //right ascension value needs to be in the same qua
        var Lquadrant = (floor(L / (90))) * 90;
        var RAquadrant = (floor(RA / 90)) * 90;
        RA = RA + (Lquadrant - RAquadrant);
        
        //right ascension value needs to be converted into hours
        RA = RA / 15;
        
        //calculate the Sun's declination
        var sinDec = 0.39782 * sin(L * D2R);
        var cosDec = cos(asin(sinDec));
        
        //calculate the Sun's local hour angle
        var cosH = (cos(zenith * D2R) - (sinDec * sin(latitude * D2R))) / (cosDec * cos(latitude * D2R));
        
        var H = 1.0;
        
        if (sunrise) {
            H = 360 - R2D * acos(cosH)
        } else {
            H = R2D * acos(cosH)
        };
        H = H / 15;
        
        //calculate local mean time of rising/setting
        var T = H + RA - (0.06571 * t) - 6.622;

        
        //adjust back to UTC
        var UT = T - lnHour;
        if (UT > 24) {
            UT = UT - 24;
        } else if (UT < 0) {
            UT = UT + 24;
        }
        
        //convert UT value to local time zone of latitude/longitude
        //UT is equivalent to GMT time, to convert you must convert based on GMT
        var gmtDiff:Double = Double((NSTimeZone.localTimeZone().secondsFromGMT))/3600;
        var localT = UT + gmtDiff;
        if (localT<0)
        {
            localT = 24 + localT;
        }
        
        return localT;
       
        
        //convert to Millisecond
        
    }
    
}





