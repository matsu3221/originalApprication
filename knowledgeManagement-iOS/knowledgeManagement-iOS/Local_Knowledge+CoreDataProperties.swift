//
//  Local_Knowledge+CoreDataProperties.swift
//  
//
//  Created by 松本唯尊 on 2020/09/29.
//
//

import Foundation
import CoreData


extension Local_Knowledge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Local_Knowledge> {
        return NSFetchRequest<Local_Knowledge>(entityName: "Local_Knowledge")
    }

    @NSManaged public var what_knowledge: String?
    @NSManaged public var type: String?
    @NSManaged public var reference_url: URL?
    @NSManaged public var knowledge_subject: String?
    @NSManaged public var id: Int64
    @NSManaged public var how_knowledge: String?
    @NSManaged public var create_date: Date?

}
