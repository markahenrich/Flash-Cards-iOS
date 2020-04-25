//
//  FlashCard+CoreDataProperties.swift
//  iCreate - Flash Cards
//
//  Created by Mark Henrich on 12/22/19.
//  Copyright © 2019 Mark Henrich. All rights reserved.
//
//

import Foundation
import CoreData


extension FlashCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCard> {
        return NSFetchRequest<FlashCard>(entityName: "FlashCard")
    }

    @NSManaged public var subject: String?
    @NSManaged public var question: String?
    @NSManaged public var answer: String?
    @NSManaged public var id: UUID
    @NSManaged public var color: Int16
    @NSManaged public var frontShowing: Bool 
    
    public var wrappedSubject: String {
        return subject ?? "Unknown"
    }
    public var wrappedQuestion: String {
        return question ?? "Unknown"
    }
    public var wrappedAnswer: String {
        return answer ?? "Unknown"
    }

}
