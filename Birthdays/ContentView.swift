//
//  ContentView.swift
//  Birthdays
//
//  Created by Scholar on 7/25/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    var body: some View {
        NavigationStack {
            
            //display birthdays
            List {
                ForEach(friends) {friend in
                    HStack{
                        Text (friend.name)
                        Spacer()
                        Text (friend.birthday, format: .dateTime.month(.wide).day().year())
                    }
                }
            .onDelete(perform: deleteFriend)
            }
           

            .navigationTitle("Birthdays")
            .safeAreaInset (edge: .bottom){
                
                //add new birthdays
                VStack (alignment: .center, spacing: 20){
                    Text ("New Birthday")
                        .font (.headline)
                    DatePicker (selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        TextField ("Name", text: $newName)
                            .textFieldStyle (.roundedBorder)
                    }
                    
                    //save birthday button
                    Button("Save"){
                        let newFriend = Friend (name: newName, birthday: newBirthday)
                        context.insert(newFriend)
                        
                        newName = ""
                        newBirthday = .now
                    }
                    .bold()
                }
                .padding ()
                .background(.bar)
            }
        }
    }
    
    //function to have option to delete friend
    func deleteFriend (at offsets: IndexSet){
        for index in offsets{
            let friendToDelete = friends [index]
            context.delete (friendToDelete)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer (for: Friend.self, inMemory: true)
}
