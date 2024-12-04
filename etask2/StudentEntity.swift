import Foundation
import CoreData

@objc(StudentEntity)
public class StudentEntity: NSManagedObject {
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var major: String?
    @NSManaged public var year: String?
    @NSManaged public var photo: Data?
}
