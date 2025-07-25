//
//  ContentView.swift
//  Birthdays
//
//  Created by Scholar on 7/25/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var friends: [Friend] = [
        Friend(name: "Taylor Swift", birthday: .now),
        Friend(name: "Frank Ocean", birthday: Date (timeIntervalSince1970: 0))]
    
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    var body: some View {
        NavigationStack {
            //adding set birthdays
            List (friends, id: \.name) { friend in
                HStack{
                    Text (friend.name)
                    Spacer()
                    Text (friend.birthday, format: .dateTime.month(.wide).day().year())
                }
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
                        friends.append(newFriend)
                        
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
}

#Preview {
    ContentView()
}
