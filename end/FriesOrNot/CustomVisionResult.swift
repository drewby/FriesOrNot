//
//  CustomVisionResult.swift
//  FriesOrNot
//
//  Created by Drew Robbins on 2017/07/30.
//  Copyright © 2017 Drew Robbins. All rights reserved.
//
// Example JSON response from Custom Vision Service: 
// {
//    "Id":"96555684-6591-4e29-8516-9d8370d775ab",
//    "Project":"d49be660-b083-4ea5-bb92-b678db9eab8b",
//    "Iteration":"95241802-bdcc-4605-8d46-de2e270fda51",
//    "Created":"2017-07-30T00:45:45.0984335Z",
//    "Predictions": [
//      {
//          "TagId":"b322a9da-245a-4793-bf98-4671b3229b52",
//          "Tag":"Fries",
//          "Probability":0.9998662
//      },
//      {
//          "TagId":"9d6f370a-0218-4e31-844e-2ea3b488c3ba",
//          "Tag":"Not Fries",
//          "Probability":0.006956966
//      }
//    ]
//}

import Foundation

struct CustomVisionPrediction {
    let TagId: String
    let Tag: String
    let Probability: Float
    
    public init(json: [String: Any]) {
        let tagId = json["TagId"] as? String
        let tag = json["Tag"] as? String
        let probability = json["Probability"] as? Float
        
        self.TagId = tagId!
        self.Tag = tag!
        self.Probability = probability!
    }
}

struct CustomVisionResult {
    let Id: String
    let Project: String
    let Iteration: String
    let Created: String
    let Predictions: [CustomVisionPrediction]
    
    public init(json: [String: Any]) throws {
        let id = json["Id"] as? String
        let project = json["Project"] as? String
        let iteration = json["Iteration"] as? String
        let created = json["Created"] as? String

        let predictionsJson = json["Predictions"] as? [[String: Any]]
        
        var predictions = [CustomVisionPrediction]()
        for predictionJson in predictionsJson! {
            do
            {
                let cvp = CustomVisionPrediction(json: predictionJson)
                predictions.append(cvp)
            }
        }
        
        self.Id = id!
        self.Project = project!
        self.Iteration = iteration!
        self.Created = created!
        self.Predictions = predictions
    }
}

