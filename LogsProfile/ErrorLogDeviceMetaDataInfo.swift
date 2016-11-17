//
//  ErrorLogDeviceMetaDataInfo.swift
//  FIMS
//
//  Created by Krutika Mac Mini on 11/16/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//


import UIKit


class ErrorLogDeviceMetaDataInfo : NSObject{
    
    var appId : String!
    var appKey : String!
    
    static let sharedInstance = ErrorLogDeviceMetaDataInfo()

    override init() {
    }
    
    func getMetaDataDictionary() -> NSMutableDictionary
    {
        let metaDataDict : NSMutableDictionary = NSMutableDictionary()
        let sysVersion = UIDevice.currentDevice().systemVersion
        let infoDict : NSDictionary = NSBundle.mainBundle().infoDictionary!
        let version = infoDict.objectForKey("CFBundleShortVersionString")
        
        if version != nil
        {
            metaDataDict.setObject(version!, forKey: "appVersion")
        }
       
        metaDataDict.setObject(self.platform(), forKey: "deviceModel")
        
        metaDataDict.setObject(sysVersion, forKey: "osVersion")
        metaDataDict.setObject("IOS", forKey: "osName")
        
        return metaDataDict
        
        
    }
    
    func platform() -> String
    {
        var size : Int = 0 // as Ben Stahl noticed in his answer
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](count: Int(size), repeatedValue: 0)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String.fromCString(machine)!
    }
    
}