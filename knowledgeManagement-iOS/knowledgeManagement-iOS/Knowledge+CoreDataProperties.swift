//
//  Knowledge+CoreDataProperties.swift
//  
//
//  Created by 松本唯尊 on 2020/09/26.
//
//

import Foundation
import CoreData


extension Knowledge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Knowledge> {
        return NSFetchRequest<Knowledge>(entityName: "Knowledge")
    }

    @NSManaged public var id: Int64
    @NSManaged public var how_knowledge: String?
    @NSManaged public var create_date: Date?
    @NSManaged public var knowledge_subject: String?
    @NSManaged public var reference_url: URL?
    @NSManaged public var what_knowledge: String?
    @NSManaged public var type: String?

}
