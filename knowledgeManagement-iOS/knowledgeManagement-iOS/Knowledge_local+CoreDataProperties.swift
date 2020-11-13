//
//  Knowledge_local+CoreDataProperties.swift
//  
//
//  Created by 松本唯尊 on 2020/09/29.
//
//

import Foundation
import CoreData


extension Knowledge_local {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Knowledge_local> {
        return NSFetchRequest<Knowledge_local>(entityName: "Knowledge_local")
    }

    @NSManaged public var what_knowledge: String?
    @NSManaged public var type: String?
    @NSManaged public var reference_url: URL?
    @NSManaged public var knowledge_subject: String?
    @NSManaged public var id: Int64
    @NSManaged public var how_knowledge: String?
    @NSManaged public var create_date: Date?

}
