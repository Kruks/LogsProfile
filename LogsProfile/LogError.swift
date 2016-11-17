//
//  LogError.swift
//  LogsProfiling
//
//  Created by Krutika Mac Mini on 11/15/16.
//  Copyright © 2016 Kahuna. All rights reserved.
//



import UIKit


// Base URL of testsuite
let errorAPIUBaseURL = "http://demo.kahunasystems.com:8080/kahunatestsuite/rest/"
//API to log Error
let serverLogsSubmit  = "logJson/create"
// API to log timestamp
let serverTimestampSubmit = "profileWebserviceLog/create"
// source of device
let logsSource = "iOS"
//Project id
let logsProjectID = "2"
// Service timeout interval
let timeOutInterval = 300

public class LogError
{
    var allowToSendServerLogs :Bool = false
    var allowToSendTimestampLogs:Bool  = false
    
    public init(){
        
    }
    
    /**
     Returns the default singleton instance.
     */
    public class func sharedManager() -> LogError
    {
        struct Static {
            //Singleton instance. Initializing keyboard manger.
            static let kbManager = LogError()
        }
        
        /** @return Returns the default singleton instance. */
        return Static.kbManager

    }
    // MARK:- allowToSendServerLogs server
    public func allowToSendServerLogs(allow:Bool)
    {
        self.allowToSendServerLogs = allow
    }
    // MARK:- allowToSendTimestampLogs server

    public func allowToSendTimestampLogs(allow:Bool)
    {
        self.allowToSendTimestampLogs = allow
    }

    
    // MARK:- Send Error Logs to server
    //  @param request:-  request for which error occured
    //  @param response:- error response from the server
    //  @param urlPath:- URL path of the service
    //  @param userName :- pass username if user is logged in
    
    public func sendDeviceLogsToServer(request:String?, with response:String?, urlPath:String, userName: String?)
    {
        
        if self.allowToSendServerLogs == true
        {
            // create request for logging error
            let errorLogs = DeviceErrorLogs()
            errorLogs.dateTime = getCurrentDate()
            errorLogs.source = logsSource
            errorLogs.user = userName
            
            var deviceInfo = ""
            
            let metaDataInfoHandler = ErrorLogDeviceMetaDataInfo()
            let metaDataDict = metaDataInfoHandler.getMetaDataDictionary()
            
            do {
                let jsonData = try NSJSONSerialization.dataWithJSONObject(metaDataDict, options: NSJSONWritingOptions.PrettyPrinted)
                let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
                print("\n\n Request : \(jsonString)")
                deviceInfo = jsonString
            } catch let error as NSError
            {
                print(error)
            }
            errorLogs.deviceInfo = deviceInfo
            
            let projectIDObj = LogsProject()
            projectIDObj.projectId = logsProjectID
            
            errorLogs.logsProject = projectIDObj;
            errorLogs.request = request
            errorLogs.response = response
            errorLogs.functionSource = urlPath
            
            let requestParameters = errorLogs.toDictionary()
            
            // send request to log error
            self.sendRequestAtPath( "\(errorAPIUBaseURL)\(serverLogsSubmit)", withParameters: requestParameters as? [String : AnyObject], timeoutInterval: timeOutInterval)

        }
        
    }
    
    
    // MARK:- Send Time Stamps to server
    //  @param serviceType:- URL path of the service
    //  @param responseStatus:- response from the server for serviceType API
    //  @param mobileReqStart :- time when service is hit from the mobile
    //  @param mobileResponseReceive :-  time when mobile gets response from the server
    //  @param serverRequestReceive :-  time when server recieved the request
    //  @param serverResponseStart :-  time when server responds to request
    //  @param mobileServiceParse :-  time taken to parse the response
    
    public func sendTimeStampLogsToServer(serviceType : String, responseStatus : String, mobileReqStart:String, mobileResponseReceive:String, mobileServiceParse:String, serverRequestReceive:String, serverResponseStart:String)
    {
        
        if allowToSendTimestampLogs == true
        {
            let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
            let qualityOfServiceClass = QOS_CLASS_BACKGROUND
            let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
            dispatch_after(dispatchTime, backgroundQueue,{
                // dispatch_async(backgroundQueue, {
                print("This is run on the background queue")
                
                // create request for logging timestamp
                
                let serverTimeStamp = ServerTimeStampLogsRequest()
                serverTimeStamp.serviceType = serviceType
                
                let projectIDObj = Project()
                
                projectIDObj.projectId = logsProjectID
                
                serverTimeStamp.project = projectIDObj
                serverTimeStamp.status = responseStatus
                serverTimeStamp.source = logsSource
                serverTimeStamp.mobileRequestStart      = mobileReqStart
                serverTimeStamp.mobileResponseReceive   = mobileResponseReceive
                serverTimeStamp.mobileServiceParsing    = mobileServiceParse
                serverTimeStamp.serverRequestReceive    = self.getFormattedDateForServerTime(serverRequestReceive)
                serverTimeStamp.serverResponseStart     = self.getFormattedDateForServerTime(serverResponseStart)
                
                let requestParameters = serverTimeStamp.toDictionary()
                
                // send request to log timestamp
                
                self.sendRequestAtPath(errorAPIUBaseURL + serverTimestampSubmit, withParameters: requestParameters as? [String : AnyObject], timeoutInterval: timeOutInterval)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print("This is run on the main queue, after the previous code in outer block")
                })
            })
 
        }
        
    }

    
    // returns current date and time
    func getCurrentDate()-> String
    {
        let date = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var dateString = dateFormatter.stringFromDate(date)
        dateString = dateString.stringByReplacingOccurrencesOfString(" ", withString: "T")
        
        return dateString
    }
    
    //Returns formatted date & time for server
    
    func getFormattedDateForServerTime(receivedDateString:String) -> String
    {
        let dateStringRe = "\(receivedDateString)"
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "US_en")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSzzz"
        let dateNew = formatter.dateFromString(dateStringRe)
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var dateString = formatter.stringFromDate(dateNew!)
        dateString = dateString.stringByReplacingOccurrencesOfString(" ", withString: "T")
        return dateString
    }
    
    // MARK: - POST TO PATH
    
    func sendRequestAtPath(path:String, withParameters parameters:[String:AnyObject]?, timeoutInterval interval:Int)
    {
        
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        request.HTTPMethod = "POST"
        
        let session = NSURLSession.sharedSession()
       
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(parameters!, options: NSJSONWritingOptions.PrettyPrinted)
            let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
            
            print("\n\n Request : \(jsonString)")
        
            request.HTTPBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.timeoutInterval = NSTimeInterval(interval)
        
        
        } catch let error as NSError {
            print(error)
        }
        

        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                print("Response Json:= \(json)")
                
            } catch let error as NSError {
                print(error)
            }
        })
        
        task.resume()
        
    }
}