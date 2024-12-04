import SwiftUI
import CoreData

class StudentViewModel: ObservableObject {
    @Published var students: [Student] = []
    
    // Функция для добавления студента
    func addStudent(firstName: String, lastName: String, major: String, year: String, photo: UIImage?) {
        let newStudent = Student(id: UUID(), firstName: firstName, lastName: lastName, major: major, year: year, photo: photo)
        students.append(newStudent)
    }
    
    // Функция для удаления студента
    func deleteStudent(at offsets: IndexSet) {
        students.remove(atOffsets: offsets)
    }
    
    // Функция для редактирования студента
    func editStudent(student: Student, firstName: String, lastName: String, major: String, year: String, photo: UIImage?) {
        if let index = students.firstIndex(where: { $0.id == student.id }) {
            students[index].firstName = firstName
            students[index].lastName = lastName
            students[index].major = major
            students[index].year = year
            students[index].photo = photo
        }
    }
}
