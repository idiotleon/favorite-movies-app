//
//  JSONParser.swift
//  favorite-movies-app
//
//  Created by Yang Lu on 10/5/17.
//  Copyright © 2017 Leon. All rights reserved.
//

import Foundation

class JSONParser{
    static func parse(data: Data) -> [String: AnyObject]?{
        print("parse() got called")
        let options = JSONSerialization.ReadingOptions()
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: options)
                as? [String: AnyObject]
            
            /* snippet to test json file validatity
            let data1 = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString:String? = String(data: data1, encoding:String.Encoding.utf8)
            print("parse, JSONParser: " + convertedString!)*/
            return json!
        }catch(let parseError){
            print("There was an error parsing the JSON: \"\(parseError.localizedDescription)\"")
        }
        
        return nil
    }
}
