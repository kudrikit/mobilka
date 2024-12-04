import SwiftUI
struct ContentView: View {
    @StateObject private var viewModel = StudentViewModel()
    @State private var showAddStudent = false
    @State private var studentToEdit: Student? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.students) { student in
                    HStack {
                        if let photo = student.photo {
                            Image(uiImage: photo)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        VStack(alignment: .leading) {
                            Text("\(student.firstName) \(student.lastName)")
                                .font(.headline)
                            Text(student.major)
                                .font(.subheadline)
                            Text("Year: \(student.year)")
                                .font(.subheadline)
                        }
                    }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            viewModel.deleteStudent(at: IndexSet([viewModel.students.firstIndex(where: { $0.id == student.id })!]))
                        }
                        
                        Button("Edit") {
                            studentToEdit = student
                            showAddStudent = true
                        }.tint(.blue)
                    }
                }
                .onDelete(perform: viewModel.deleteStudent)
            }
            .navigationTitle("Students")
            .toolbar {
                Button(action: {
                    studentToEdit = nil
                    showAddStudent = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddStudent) {
                AddEditStudentView(viewModel: viewModel, studentToEdit: $studentToEdit)
            }
        }
    }
}
