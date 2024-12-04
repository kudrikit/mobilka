import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Telefon fake, chekni console")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                displayPersonInfo()
            }) {
                Text("console")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    func displayPersonInfo() {
        let person = Person(name: "Kudaibergen", dateOfBirth: "2003-12-13", placeOfBirth: "Almaty", nationality: "Kazakh", occupation: "Student")
        let mother = FamilyMember(name: "Sholpan", relationship: "Mother", age: 62)
        let brother = Sibling(name: "Daniar", age: 40, hobby: "Racer")
        
        print("Person Info:")
        print("Name: \(person.getName())")
        print("Date of Birth: \(person.getDateOfBirth())")
        print("Place of Birth: \(person.getPlaceOfBirth())")
        print("Nationality: \(person.getNationality())")
        print("Occupation: \(person.getOccupation())")
        //------------------------------
        print("\nFamily Member Info:")
        print("Name: \(mother.getName())")
        print("Relationship: \(mother.getRelationship())")
        print("Age: \(mother.getAge())")
        //-----------------------------
        print("\nSibling Info:")
        print("Name: \(brother.getName())")
        print("Age: \(brother.getAge())")
        print("Hobby: \(brother.getHobby())")
    }
}
