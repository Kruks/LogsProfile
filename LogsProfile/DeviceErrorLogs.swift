//
//	DeviceErrorLogs.swift
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class DeviceErrorLogs : NSObject, NSCoding{

	var dateTime : String!
	var deviceInfo : String!
	var logsProject : LogsProject!
	var request : String!
	var response : String!
	var source : String!
	var user : String!
    var functionSource : String!

    override init() {
    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		dateTime = dictionary["dateTime"] as? String
		deviceInfo = dictionary["deviceInfo"] as? String
		if let logsProjectData = dictionary["logsProject"] as? NSDictionary{
			logsProject = LogsProject(fromDictionary: logsProjectData)
		}
		request = dictionary["request"] as? String
		response = dictionary["response"] as? String
		source = dictionary["source"] as? String
		user = dictionary["user"] as? String
        functionSource = dictionary["functionSource"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if dateTime != nil{
			dictionary["dateTime"] = dateTime
		}
		if deviceInfo != nil{
			dictionary["deviceInfo"] = deviceInfo
		}
		if logsProject != nil{
			dictionary["logsProject"] = logsProject.toDictionary()
		}
		if request != nil{
			dictionary["request"] = request
		}
		if response != nil{
			dictionary["response"] = response
		}
		if source != nil{
			dictionary["source"] = source
		}
		if user != nil{
			dictionary["user"] = user
		}
        
        if functionSource != nil{
            dictionary["functionSource"] = functionSource
        }

		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         dateTime = aDecoder.decodeObjectForKey("dateTime") as? String
         deviceInfo = aDecoder.decodeObjectForKey("deviceInfo") as? String
         logsProject = aDecoder.decodeObjectForKey("logsProject") as? LogsProject
         request = aDecoder.decodeObjectForKey("request") as? String
         response = aDecoder.decodeObjectForKey("response") as? String
         source = aDecoder.decodeObjectForKey("source") as? String
         user = aDecoder.decodeObjectForKey("user") as? String
         functionSource = aDecoder.decodeObjectForKey("functionSource") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if dateTime != nil{
			aCoder.encodeObject(dateTime, forKey: "dateTime")
		}
		if deviceInfo != nil{
			aCoder.encodeObject(deviceInfo, forKey: "deviceInfo")
		}
		if logsProject != nil{
			aCoder.encodeObject(logsProject, forKey: "logsProject")
		}
		if request != nil{
			aCoder.encodeObject(request, forKey: "request")
		}
		if response != nil{
			aCoder.encodeObject(response, forKey: "response")
		}
		if source != nil{
			aCoder.encodeObject(source, forKey: "source")
		}
		if user != nil{
			aCoder.encodeObject(user, forKey: "user")
		}
        if functionSource != nil{
            aCoder.encodeObject(functionSource, forKey: "functionSource")
        }


	}

}