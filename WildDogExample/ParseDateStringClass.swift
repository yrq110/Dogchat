//
//  ParseDateStringClass.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/4/6.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import Foundation

class Parse{
    
    enum DayTimePeriod : Int{
        case morning = 0
        case noon = 1
        case afternoon = 2
        case evening = 3
        case night = 4
    }
    
    //季节
    enum Season : Int{
        case Spring = 0 //春
        case Summer = 1 //夏
        case Autumn = 2 //秋
        case Winter = 3 //冬
    }
    
    //天气
    enum Weather : Int{
        case Sunny = 0 //晴天
        case Cloudy = 1 //多云
        case Overcast = 2 //阴天
        case LightRain = 3 //小雨
        case ModerateRain = 4 //中雨
        case HeavyRain = 5 //大雨
        case LightSnow = 6 //小雪
        case ModerateSnow = 7 //中雪
        case HeavySnow = 8 //大雪
        case RainStorm = 9 //暴雨
        case ThunderStorm = 10 //雷雨
        case Fog = 11 //雾
        case Frost = 12 //霜冻
        case Sleet = 13 //雨夹雪
        case Typhoon = 14 //台风
        case sandStorm = 15 //沙尘暴
    }
    
    //节日
    enum Festival:String {
        case NewYearsDay = "1-1" //元旦
        //        case SpringFestival = "1-1" //春节
        case WomensDay = "3-8" //妇女节
        case ArborDay = "3-12" //植树节
        //        case ChingMingFestival = "1-1" //清明节
        case LaborDay = "5-1" //劳动节
        case YouthDay = "5-4" //青年节
        //        case DragonBoatFestival = "1-1" //端午节
        case ChildrensDay = "6-1" //儿童节
        //        case LanternFestival = "1-1" //
        //        case MidAutumnFestival = "1-1"//中秋节
        //        case DoubleNinthDay = "1-1" //重阳节
        case NationalDay = "10-1" //国庆节
        case NewYearsEve = "12-31" //除夕
    }
    
    func parseStr(str:String) -> (Int,Int,String,Int){
        
        let onceSplit = str.characters.split{$0 == "."}.map(String.init)
        let month = String(Int(onceSplit[0].characters.split{$0 == "-"}.map(String.init)[1]
            )!)
        let day = String(Int(onceSplit[0].characters.split{$0 == "-"}.map(String.init)[2])!)
        let date = month + "-" + day
        let dayTime = Int(onceSplit[1].characters.split{$0 == ":"}.map(String.init)[0])
        
        var season : Season
        var daytime : DayTimePeriod
        var weather : Weather = Weather.Sunny
        var festival : Festival
        
        switch Int(month)! {
        case 12,1,2 : season = Season.Winter
        case 3...5 : season = Season.Spring
        case 6...8 : season = Season.Summer
        case 9...11 : season = Season.Autumn
        default : season = Season.Spring
        }
        
        switch dayTime! {
        case 6...9: daytime = DayTimePeriod.morning
        case 10...14: daytime = DayTimePeriod.noon
        case 15...18: daytime = DayTimePeriod.afternoon
        case 19...22: daytime = DayTimePeriod.evening
        case 22,23,24,0...5: daytime = DayTimePeriod.night
            
        default: daytime = DayTimePeriod.morning
        }
        
        switch day {
        case "1-1": festival = Festival.NewYearsDay
        case "3-8": festival = Festival.WomensDay
        case "3-12": festival = Festival.ArborDay
        case "5-1": festival = Festival.LaborDay
        case "5-4": festival = Festival.YouthDay
        case "6-1": festival = Festival.ChildrensDay
        case "10-1": festival = Festival.NationalDay
        case "12-31": festival = Festival.NewYearsEve
        default: festival = Festival.NewYearsDay
        }
        
        return (season.rawValue,daytime.rawValue,festival.rawValue,weather.rawValue)
    }
}