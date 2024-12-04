import SwiftUI
import CoreData
import PhotosUI

// Модель Студента (с Core Data)
struct Student: Identifiable {
    let id: UUID
    var firstName: String
    var lastName: String
    var major: String
    var year: String
    var photo: UIImage?
}

