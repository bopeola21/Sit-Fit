//
//  FourSquareRequest.swift
//  Maps
//
//  Created by Jide Opeola on 2/2/15.
//  Copyright (c) 2015 Jide Opeola. All rights reserved.
//

import UIKit
import CoreLocation

let API_URL = "https://api.foursquare.com/v2/"
let CLIENT_ID = "RYLBWDM5PKXHMCYRLFYUTFHPFMHADGKHWSYKQ5YRHQEEADZU"
let CLIENT_SECRET = "KEV1SHIJRONBG3BDO3T1LWZEDP0XATEMOHXCLMZFBA3AMIXY"

class FourSquareRequest: NSObject {
    
    class func requestVenuesWithLocation(location: CLLocation) -> [AnyObject] {
        
        let requestString = "\(API_URL)venues/search?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20130815&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
        
      //  println(requestString)
        
        
        if   let url = NSURL(string: requestString) {
            
            let request = NSURLRequest(URL: url)
            
            
            if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) {
                
                if let returnInfo = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject]{
                    
                    let responseInfo = returnInfo["response"] as [String:AnyObject]
                    
                    // lets xcode know "venues" is anyobject, rather than putting it in the line above
                    let venues = responseInfo["venues"] as [AnyObject]
                    
                    return venues
                    
                }
                
            }
            
            
            
            
        }
        
        
        
        
        
        
        return[]
        
    }
   
}
