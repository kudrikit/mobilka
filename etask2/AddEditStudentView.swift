import SwiftUI
import PhotosUI

struct AddEditStudentView: View {
    @ObservedObject var viewModel: StudentViewModel
    @Binding var studentToEdit: Student?
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var major = ""
    @State private var year = ""
    @State private var photo: UIImage?
    @State private var showPhotoPicker = false
    
    // Заполняем поля, если редактируем студента
    private var isEditing: Bool {
        studentToEdit != nil
    }
    
    private var title: String {
        isEditing ? "Edit Student" : "Add Student"
    }
    
    private var saveButtonTitle: String {
        isEditing ? "Save Changes" : "Save"
    }
    
    private func saveStudent() {
        if isEditing, let student = studentToEdit {
            viewModel.editStudent(student: student, firstName: firstName, lastName: lastName, major: major, year: year, photo: photo)
        } else {
            viewModel.addStudent(firstName: firstName, lastName: lastName, major: major, year: year, photo: photo)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                
                Section(header: Text("Details")) {
                    TextField("Major", text: $major)
                    TextField("Year", text: $year)
                }
                
                Section(header: Text("Photo")) {
                    if let photo = photo {
                        Image(uiImage: photo)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Button("Select Photo") {
                            showPhotoPicker = true
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        studentToEdit = nil
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(saveButtonTitle) {
                        saveStudent()
                        studentToEdit = nil // Закрытие формы после сохранения
                    }
                }
            }
            .sheet(isPresented: $showPhotoPicker) {
                PhotoPicker(photo: $photo)
            }
        }
        .onAppear {
            if let student = studentToEdit {
                firstName = student.firstName
                lastName = student.lastName
                major = student.major
                year = student.year
                photo = student.photo
            }
        }
    }
}

