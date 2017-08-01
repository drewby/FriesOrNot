//
//  FaceApiService.swift
//
//  Created by Drew Robbins on 2017/08/02.
//  Copyright © 2017 Drew Robbins. All rights reserved.
//

import Foundation

class FaceApiService {
    var faceApiUrl = "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect";
    var parameters = "returnFaceId=true&returnFaceLandmarks=false&returnFaceAttributes=age,gender,headPose,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise";
    var faceApiKey = ""
    var contentType = "application/octet-stream"
    
    var defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func predict(image: Data, completion: @escaping (String?, Error?) -> Void) {
        
        // Create URL Request
        var urlRequest = URLRequest(url: URL(string: faceApiUrl + "?" + parameters)!)
        urlRequest.addValue(faceApiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        urlRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        // Cancel existing dataTask if active
        dataTask?.cancel()
        
        // Create new dataTask to upload image
        dataTask = defaultSession.uploadTask(with: urlRequest, from: image) { data, response, error in
            defer { self.dataTask = nil }
            
            if let error = error {
                completion(nil, error)
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                if let json = try? JSONSerialization.jsonObject(with: data) as? [Any] {
                    if (json?.count)!>0 {
                        let face = json?[0] as? [String: Any]

                        let faceAttributes = face?["faceAttributes"] as? [String: Any]
                        let gender = (faceAttributes?["gender"] as? String)!
                        let age = (faceAttributes?["age"] as? Float)!
                        
                        let result = "Looks like a \(gender) who is \(age) years old."
                        completion(result, nil)
                    } else {
                        
                    }
                }
            }
        }
        
        // Start the new dataTask
        dataTask?.resume()
    }
    
}
