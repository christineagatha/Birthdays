//
//  ContentView.swift
//  Birthdays
//
//  Created by christine j on 4/27/25.
//

import SwiftUI

struct ContentView: View {
    @State private var friends: [Friend] = [
        // I'm not sure if we are supposed to calculate the correct birthday
        Friend(name: "Christine Jiang", birthday: Date(timeIntervalSinceReferenceDate: 12345)),
        Friend(name: "Emily Iorio", birthday: Date(timeIntervalSinceReferenceDate: 67890 ))
    ]
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    var body: some View {
        NavigationStack {
            List(friends, id: \.name) { friend in
                HStack {
                    Text(friend.name)
                    Text(friend.birthday,format: .dateTime.month(.wide).day().year())
                }
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 5) {
                    Text("New Birthday")
                    DatePicker(selection: $newBirthday) {
                        TextField("Name", text: $newName)
                    }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        friends.append(newFriend)
                        newName = ""
                        newBirthday = Date.now
                    }
                }
                .padding()
                .background(.gray.opacity(0.3))
            }
        }
    }
}

#Preview {
    ContentView()
}
