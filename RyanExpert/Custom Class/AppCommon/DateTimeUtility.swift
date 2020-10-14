//
//  DateTimeUtility.swift
//  Cozy Up
//
//  Created by Keyur on 15/10/18.
//  Copyright © 2018 Keyur. All rights reserved.
//

import Foundation

func getCurrentTimeStampValue() -> String
{
    return String(format: "%0.0f", Date().timeIntervalSince1970)
}

func getTimestampFromDate(date : Date) -> Double
{
    return date.timeIntervalSince1970
}

func getDateFromTimeStamp(_ timeStemp:Double) -> Date
{
    return Date(timeIntervalSince1970: TimeInterval(timeStemp))
}

func getDateStringFromServerTimeStemp(_ timeStemp:Double) -> String {
    
    let date : Date = Date(timeIntervalSince1970: TimeInterval(timeStemp))
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "dd MMM yyyy"//DATE_FORMAT.DISPLAY_DATE_FORMAT
    return dateFormatter.string(from: date)
}
func getTimeStringFromServerTimeStemp(_ timeStemp:Double) -> String {
    
    let date : Date = Date(timeIntervalSince1970: TimeInterval(timeStemp))
    let dateFormatter = DateFormatter()
    //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    //dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "hh:mm a"//DATE_FORMAT.DISPLAY_TIME_FORMAT
    return dateFormatter.string(from: date)
}

func getDateTimeStringFromServerTimeStemp(_ timeStemp:Double) -> String{
    
    let date : Date = Date(timeIntervalSince1970: TimeInterval(timeStemp/1000))
    
    let dateFormatter = DateFormatter()
    //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = DATE_FORMAT.DISPLAY_DATE_TIME_FORMAT
    return dateFormatter.string(from: date)
}

//use function
func getDateStringFromDate(date : Date) -> String
{
    let dateFormatter = DateFormatter()
    //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = DATE_FORMAT.SERVER_DATE_TIME_FORMAT
    return dateFormatter.string(from: date)
}

func getTimeStringFromDate(date : Date) -> String
{
    let dateFormatter = DateFormatter()
    //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = DATE_FORMAT.DISPLAY_TIME_FORMAT
    return dateFormatter.string(from: date)
}

func getDateStringFromDate(date : Date, format : String) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

func getDateStringFromDateWithCurrentLangugae(date : Date, format : String) -> String
{
    let dateFormatter = DateFormatter()
//    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.init(localeIdentifier: NSLocale.preferredLanguages[0]) as Locale
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

func getDateFromDateString(strDate : String, format : String) -> Date?
{
    let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
//    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: strDate)
}

func getDateFromDateString(strDate : String) -> Date
{
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
   // dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "dd-MM-yyyy"//DATE_FORMAT.DISPLAY_DATE_FORMAT
    return dateFormatter.date(from: strDate)!
}

func getDateFromDateString1(strDate : String) -> String
{
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "YYYY-MM-dd"
    let date1 =  dateFormatter1.date(from: strDate)!
    dateFormatter1.dateFormat = "dd-MM-YYYY"
    return dateFormatter1.string(from: date1)
}

func getDateFromDateString2(strDate : String) -> String
{
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "dd-MM-YYYY"
    let date1 =  dateFormatter1.date(from: strDate)!
    dateFormatter1.dateFormat = "YYYY-MM-dd"
    return dateFormatter1.string(from: date1)
}

func getDateStringFromDateString(strDate : String) -> String    // Today, 09:56 AM
{
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "YYYY-MM-dd HH:mm:ss"
    let date1 =  dateFormatter1.date(from: strDate)!
    dateFormatter1.dateFormat = "hh:mm a"
    let time = dateFormatter1.string(from: date1)
    let dateStr = getdayDifferenceFromCurrentDayDate(date1)
    return dateStr + ", " + time
}

func getTimeStringFromDateString(strDate : String) -> Date    // 09:56 AM
{
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "YYYY-MM-dd HH:mm:ss"
    let date1 =  dateFormatter1.date(from: strDate)!
 //   dateFormatter1.dateFormat = "HH:mm a"
    return date1
}

func getTimeStringFromDateString1(strDate : String) -> String    // 09:56 AM
{
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "YYYY-MM-dd HH:mm:ss"
    let date1 =  dateFormatter1.date(from: strDate)!
    dateFormatter1.dateFormat = "HH:mm a"
    return dateFormatter1.string(from: date1)
}


//MARK: Date difference
func getDifferenceFromCurrentTime(_ timeStemp : Double) -> Int
{
    let newDate : Date = Date(timeIntervalSince1970: TimeInterval(timeStemp))
    let currentDate : Date = getCurrentDate()
    let interval = currentDate.timeIntervalSince(newDate)
    return Int(interval)
}

func getCurrentDate() -> Date
{
    let currentDate : Date = Date()
    return currentDate
}

func getDifferenceFromCurrentTimeInHourInDays(_ timestamp : Double) -> String
{
    let interval : Int = getDifferenceFromCurrentTime(timestamp)
    
    let second : Int = interval
    let minutes : Int = interval/60
    let hours : Int = interval/(60*60)
    let days : Int = interval/(60*60*24)
    let week : Int = interval/(60*60*24*7)
    let months : Int = interval/(60*60*24*30)
    let years : Int = interval/(60*60*24*30*12)
    
    var timeAgo : String = ""
    if  second < 60
    {
        timeAgo = (second < 3) ? getTranslate("just_now") : (String(second) + getTranslate("second_sort"))
    }
    else if minutes < 60
    {
        timeAgo = String(minutes) + getTranslate("minute_sort")
    }
    else if hours < 24
    {
        timeAgo = String(hours) + getTranslate("hour_sort")
    }
    else if days < 30
    {
        timeAgo = String(days) + " "  + ((days > 1) ? getTranslate("days_sort") : getTranslate("day_sort"))
    }
    else if week < 4
    {
        timeAgo = String(week) + " "  + ((week > 1) ? getTranslate("weeks_sort") : getTranslate("week_sort"))
    }
    else if months < 12
    {
        timeAgo = String(months) + " "  + ((months > 1) ? getTranslate("months_sort") : getTranslate("month_sort"))
    }
    else
    {
        timeAgo = String(years) + " "  + ((years > 1) ? getTranslate("years_sort") : getTranslate("year_sort"))
    }
    
//    if second > 3 {
//        timeAgo = timeAgo + " ago"
//    }
    return timeAgo
}


func getTodayString() -> String{
    
    let date = Date()
    let calender = Calendar.current
    let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    
    let year = components.year
    let month = components.month
    let day = components.day
    let hour = components.hour
    let minute = components.minute
    let second = components.second
    
    let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
    
    return today_string
    
}

func isSameDateString(firstDate : String, secondDate : String) -> Bool
{
    let strDate1 : String = getDateStringFromServerTimeStemp(Double(firstDate)!)
    let strDate2 : String = getDateStringFromServerTimeStemp(Double(secondDate)!)
    
    if strDate1 == strDate2
    {
        return true
    }
    return false
}

func isSameDate(firstDate : String, secondDate : String) -> Bool
{
    let strDate1 : String = getDateStringFromServerTimeStemp(Double(firstDate)!)
    let strDate2 : String = getDateStringFromServerTimeStemp(Double(secondDate)!)
        
    if strDate1 == strDate2
    {
        return true
    }
    return false
}

func getdayDifferenceFromCurrentDay(_ timeStemp : Double) -> String
{
    let calendar = NSCalendar.current
    let date1 = calendar.startOfDay(for: Date(timeIntervalSince1970: TimeInterval(timeStemp)))
    let date2 = calendar.startOfDay(for: getCurrentDate())
    
    let components = calendar.dateComponents([.day], from: date1, to: date2)
    
    var timeAgo : String = ""
    if components.day == 0
    {
        timeAgo = getTranslate("today")
    }
    else if components.day == 1
    {
        timeAgo = getTranslate("yesterday")
    }
    else
    {
        timeAgo = getDateStringFromServerTimeStemp(TimeInterval(timeStemp))
    }
    
    return timeAgo
}

func getdayDifferenceFromCurrentDayDate(_ selectDate : Date) -> String
{
    let calendar = NSCalendar.current
    let date1 = calendar.startOfDay(for: selectDate)
    let date2 = calendar.startOfDay(for: getCurrentDate())
    
    let components = calendar.dateComponents([.day], from: date1, to: date2)
    
    var timeAgo : String = ""
    if components.day == 0
    {
        timeAgo = getTranslate("today")
    }
    else if components.day == 1
    {
        timeAgo = getTranslate("yesterday")
    }
    else
    {
        timeAgo = getDateStringFromDate(date: selectDate, format: "dd-MM-yyyy")
    }
    
    return timeAgo
}


func getDateOnlyFromDate(date : Date) -> String
{
    let dateFormatter = DateFormatter()
    //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "d"
    return dateFormatter.string(from: date)
}

func get24HoureIn12Houre(time : String) -> String {
    let houreMin = time.components(separatedBy: ":")
    var time12: String = time
    if Int(houreMin[0])! < 12 {
        time12 = houreMin[0] + ":" + houreMin[1] + " AM"
    } else {
        time12 = String(Int(houreMin[0])! - 12) + ":" + houreMin[1] + " PM"
    }
    
    return time12
}

func getMonthOnlyFromDate(date : Date) -> String
{
    let dateFormatter = DateFormatter()
    //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "m"
    return dateFormatter.string(from: date)
}


func getOnlyDateTimestamp(date : Date) -> Double
{
    let strDate : String = getDateStringFromDate(date: date)
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
//    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = DATE_FORMAT.DISPLAY_DATE_FORMAT
    return getTimestampFromDate(date: dateFormatter.date(from: strDate)!)
}

func getDateTimeStringForChat(_ timesstamp : Double) -> String
{
    let date : Date = getDateFromTimeStamp(timesstamp)
    return getOrdinalDate(date: date)
}

func getOrdinalDate(date : Date) -> String{
    // Day
    let calendar = Calendar.current
    let anchorComponents = calendar.dateComponents([.day, .month, .year], from: date)
    
    // Formate
    let dateFormate = DateFormatter()
    dateFormate.dateFormat = "MMMM yyyy"
    let newDate = dateFormate.string(from: date)
    
    var day  = "\(anchorComponents.day!)"
    switch (day) {
    case "1" , "21" , "31":
        day.append("st")
    case "2" , "22":
        day.append("nd")
    case "3" ,"23":
        day.append("rd")
    default:
        day.append("th")
    }
    return day + " " + newDate
}

func getUserAge(date : Date) -> Int
{
    let calendar = Calendar.current
    let totalYear = calendar.dateComponents([.year], from: date, to: Date())
    return totalYear.year!
}

func getMinimumDateOfBirth() -> Date
{
    return Calendar.current.date(
        byAdding: .year,
        value: -18,
        to: Date())!
}

func getDateFromComponent(_ day : Int, _ month : Int, _ year : Int) -> String
{
    let strDate : String = String(day) + "/" + String(month) + "/" + String(year)
    
    let dateFormatter = DateFormatter()
//    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = DATE_FORMAT.DISPLAY_DATE_FORMAT
    let date : Date = dateFormatter.date(from: strDate)!
    return getDateStringFromDate(date: date)
}

func getTimeFromComponent(_ hours : Int, _ minutes : Int) -> String
{
    var time : String = String(hours) + ":" + String(minutes)
    if hours < 12
    {
        time = time + getTranslate("AM")
    }
    else
    {
        time = time + getTranslate("PM")
    }
    
    return time
}

func getDurationFromComponent(_ hours : Int, _ minutes : Int) -> String
{
    return (String(hours) + ":" + String(minutes) + " hours")
}


func getHoursMinutesSecondsFrom(seconds: Double) -> String {
    let secs = Int(seconds)
    _ = (secs / 3600)
    let minutes = (secs % 3600) / 60
    let seconds = (secs % 3600) % 60
    
    var minString : String = String(minutes)
    if minString.count == 1
    {
        minString = "0" + minString
    }
    var secString : String = String(seconds)
    if secString.count == 1
    {
        secString = "0" + secString
    }
    
    return minString + ":" + secString
}

func getTotalDays(_ currentDate : Date) -> Int
{
    let calendar = Calendar.current
    let interval = calendar.dateInterval(of: .month, for: currentDate)!
    let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
    return days
}

func getTimeSlotDuration(_ timeslot_time_from : String, _ timeslot_time_to : String) -> String
{
    let oldDate : Date = getDateFromDateString(strDate: timeslot_time_from, format: "hh:mm a")!
    let newDate : Date = getDateFromDateString(strDate: timeslot_time_to, format: "hh:mm a")!
    let interval = Int(newDate.timeIntervalSince(oldDate))
    
    let second : Int = interval
    let minutes : Int = interval/60
    let hours : Int = interval/(60*60)
    
    var timeAgo : String = ""
    if  second < 60
    {
        timeAgo = String(second) + getTranslate("second_word")
    }
    else if minutes < 60
    {
        timeAgo = String(minutes) + getTranslate("minute_word")
    }
    else if hours < 24
    {
        timeAgo = String(hours) + getTranslate("hour_word")
    }
    return timeAgo
}
