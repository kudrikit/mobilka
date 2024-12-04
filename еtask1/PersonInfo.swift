import Foundation

class Person {
    private var name: String
    private var dateOfBirth: String
    private var placeOfBirth: String
    private var nationality: String
    private var occupation: String
    
    init(name: String, dateOfBirth: String, placeOfBirth: String, nationality: String, occupation: String) {
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.placeOfBirth = placeOfBirth
        self.nationality = nationality
        self.occupation = occupation
    }
    
    func getName() -> String {
        return name
    }
    
    func getDateOfBirth() -> String {
        return dateOfBirth
    }
    
    func getPlaceOfBirth() -> String {
        return placeOfBirth
    }
    
    func getNationality() -> String {
        return nationality
    }
    
    func getOccupation() -> String {
        return occupation
    }
}

//--------------------------------------
class FamilyMember {
    private var name: String
    private var relationship: String
    private var age: Int
    
    init(name: String, relationship: String, age: Int) {
        self.name = name
        self.relationship = relationship
        self.age = age
    }
    
    
    func getName() -> String {
        return name
    }
    
    func getRelationship() -> String {
        return relationship
    }
    
    func getAge() -> Int {
        return age
    }
}


//-----------------------------------
class Sibling {
    private var name: String
    private var age: Int
    private var hobby: String
    
    init(name: String, age: Int, hobby: String) {
        self.name = name
        self.age = age
        self.hobby = hobby
    }
    
    func getName() -> String {
        return name
    }
    
    func getAge() -> Int {
        return age
    }
    
    func getHobby() -> String {
        return hobby
    }
}
