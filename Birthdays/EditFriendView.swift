//
//  EditFriendView.swift
//  Birthdays
//
//  Created by Scholar on 7/25/25.
//

import SwiftUI

struct EditFriendView: View {
    var friend: Friend
    @State private var newName: String
    @State private var newBirthday: Date
    @Environment(\.dismiss) private var dismiss
    
    init(friend: Friend) {
        self.friend = friend
        _newName = State(initialValue: friend.name)
        _newBirthday = State(initialValue: friend.birthday)
    }
    
    var body: some View {
        Form {
            //display friends current name and birthday
            TextField ("Name", text: $newName)
            DatePicker ("Birthday", selection: $newBirthday, displayedComponents: .date)
        }
        .navigationTitle ("Edit Friend")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss ()
                }
            }
            ToolbarItem (placement: .confirmationAction){
                Button ("Save"){
                    friend.name = newName
                    friend.birthday = newBirthday
                    dismiss ()
                }
            }
        }
    }
    
    #Preview {
        NavigationStack {
            EditFriendView(friend: Friend(name: "Test", birthday: Date.now))
        }
    }
}
