//
//	ServerTimeStampLogsRequest.swift
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ServerTimeStampLogsRequest : NSObject, NSCoding{

	var mobileRequestStart : String!
	var mobileResponseReceive : String!
	var mobileServiceParsing : String!
	var project : Project!
	var serverRequestReceive : String!
	var serverResponseStart : String!
	var serviceType : String!
	var status : String!
    var source : String!

    override init() {
    }

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		mobileRequestStart = dictionary["mobileRequestStart"] as? String
		mobileResponseReceive = dictionary["mobileResponseReceive"] as? String
		mobileServiceParsing = dictionary["mobileServiceParsing"] as? String
		if let projectData = dictionary["project"] as? NSDictionary{
			project = Project(fromDictionary: projectData)
		}
		serverRequestReceive = dictionary["serverRequestReceive"] as? String
		serverResponseStart = dictionary["serverResponseStart"] as? String
		serviceType = dictionary["serviceType"] as? String
		status = dictionary["status"] as? String
        source = dictionary["source"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if mobileRequestStart != nil{
			dictionary["mobileRequestStart"] = mobileRequestStart
		}
		if mobileResponseReceive != nil{
			dictionary["mobileResponseReceive"] = mobileResponseReceive
		}
		if mobileServiceParsing != nil{
			dictionary["mobileServiceParsing"] = mobileServiceParsing
		}
		if project != nil{
			dictionary["project"] = project.toDictionary()
		}
		if serverRequestReceive != nil{
			dictionary["serverRequestReceive"] = serverRequestReceive
		}
		if serverResponseStart != nil{
			dictionary["serverResponseStart"] = serverResponseStart
		}
		if serviceType != nil{
			dictionary["serviceType"] = serviceType
		}
		if status != nil{
			dictionary["status"] = status
		}
        if source != nil{
            dictionary["source"] = source
        }

		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         mobileRequestStart = aDecoder.decodeObjectForKey("mobileRequestStart") as? String
         mobileResponseReceive = aDecoder.decodeObjectForKey("mobileResponseReceive") as? String
         mobileServiceParsing = aDecoder.decodeObjectForKey("mobileServiceParsing") as? String
         project = aDecoder.decodeObjectForKey("project") as? Project
         serverRequestReceive = aDecoder.decodeObjectForKey("serverRequestReceive") as? String
         serverResponseStart = aDecoder.decodeObjectForKey("serverResponseStart") as? String
         serviceType = aDecoder.decodeObjectForKey("serviceType") as? String
         status = aDecoder.decodeObjectForKey("status") as? String
         source = aDecoder.decodeObjectForKey("source") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if mobileRequestStart != nil{
			aCoder.encodeObject(mobileRequestStart, forKey: "mobileRequestStart")
		}
		if mobileResponseReceive != nil{
			aCoder.encodeObject(mobileResponseReceive, forKey: "mobileResponseReceive")
		}
		if mobileServiceParsing != nil{
			aCoder.encodeObject(mobileServiceParsing, forKey: "mobileServiceParsing")
		}
		if project != nil{
			aCoder.encodeObject(project, forKey: "project")
		}
		if serverRequestReceive != nil{
			aCoder.encodeObject(serverRequestReceive, forKey: "serverRequestReceive")
		}
		if serverResponseStart != nil{
			aCoder.encodeObject(serverResponseStart, forKey: "serverResponseStart")
		}
		if serviceType != nil{
			aCoder.encodeObject(serviceType, forKey: "serviceType")
		}
		if status != nil{
			aCoder.encodeObject(status, forKey: "status")
		}
        if source != nil{
            aCoder.encodeObject(source, forKey: "source")
        }
	}

}